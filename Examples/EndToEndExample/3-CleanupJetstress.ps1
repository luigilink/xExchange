<#
.EXAMPLE
    This example shows how to cleanup jet stress.
#>

$ConfigurationData = @{
    AllNodes = @(
        @{
            #region Common Settings for All Nodes
            NodeName        = '*'

            <#
                NOTE! THIS IS NOT RECOMMENDED IN PRODUCTION.
                This is added so that AppVeyor automatic tests can pass, otherwise
                the tests will fail on passwords being in plain text and not being
                encrypted. Because it is not possible to have a certificate in
                AppVeyor to encrypt the passwords we need to add the parameter
                'PSDscAllowPlainTextPassword'.
                NOTE! THIS IS NOT RECOMMENDED IN PRODUCTION.
                See:
                http://blogs.msdn.com/b/powershell/archive/2014/01/31/want-to-secure-credentials-in-windows-powershell-desired-state-configuration.aspx
            #>
            PSDscAllowPlainTextPassword = $true

            #The product key to license Exchange 2013
            ProductKey = '12345-12345-12345-12345-12345'

            #The paths to the CSV files generated by the Server Role Requirements Calculator
            ServersCsvPath               = "C:\Demo\Calculators\Lab\Servers.csv"
            MailboxDatabasesCsvPath      = "C:\Demo\Calculators\Lab\MailboxDatabases.csv"
            MailboxDatabaseCopiesCsvPath = "C:\Demo\Calculators\Lab\MailboxDatabaseCopies.csv"

            #DiskToDBMap used by xExchAutoMountPoint specifically for Jetstress purposes
            JetstressDiskToDBMap = 'DB1,DB2,DB3,DB4','DB5,DB6,DB7,DB8'

            #The base file server UNC path that will be used for copying things like certificates, Exchange binaries, and Jetstress binaries
            FileServerBase = '\\rras-1.mikelab.local\Binaries'

            #endregion
        }

        #region Individual Node Settings
        #region DAG01 Nodes
        @{
            NodeName        = 'e15-1'
            Fqdn            = 'e15-1.mikelab.local'
            Role            = 'AdditionalDAGMember'
            DAGId           = 'DAG01'
            CASId           = 'Site1CAS'
            ServerNameInCsv = 'e15-1'          
        }

        @{
            NodeName        = 'e15-2'
            Fqdn            = 'e15-2.mikelab.local'
            Role            = 'AdditionalDAGMember'
            DAGId           = 'DAG01'
            CASId           = 'Site1CAS'
            ServerNameInCsv = 'e15-2'
        }

        @{
            NodeName        = 'e15-3'
            Fqdn            = 'e15-3.mikelab.local'
            Role            = 'FirstDAGMember'
            DAGId           = 'DAG01'
            CASId           = 'Site2CAS'
            ServerNameInCsv = 'e15-3'       
        }

        @{
            NodeName        = 'e15-4'
            Fqdn            = 'e15-4.mikelab.local'
            Role            = 'AdditionalDAGMember'
            DAGId           = 'DAG01'
            CASId           = 'Site2CAS'
            ServerNameInCsv = 'e15-4'
        }
        #endregion
    );

    #region DAG Settings
    DAG01 = @(
        @{
            DAGName                              = 'DAG01'           
            AutoDagTotalNumberOfServers          = 12
            AutoDagDatabaseCopiesPerVolume       = 4
            DatabaseAvailabilityGroupIPAddresses = '192.168.1.31','192.168.2.31'
            WitnessServer                        = 'e14-1.mikelab.local'
            DbNameReplacements                   = @{"nn" = "01"}
            Thumbprint                           = "0079D0F68F44C7DA5252B4779F872F46DFAF0CBC"
        }
    )
    #endregion

    #region CAS Settings
    #Settings that will apply to all CAS
    AllCAS = @(
        @{
            ExternalNamespace = 'mail.mikelab.local'
        }
    )

    #Settings that will apply only to Quincy CAS
    Site1CAS = @(
        @{
            InternalNamespace          = 'mail-site1.mikelab.local'
            AutoDiscoverSiteScope      = 'Site1'
            InstantMessagingServerName = 'l15-1.mikelab.local'
            DefaultOAB                 = "Default Offline Address Book (Site1)"
        }
    );

    #Settings that will apply only to Phoenix CAS
    Site2CAS = @(
        @{
            InternalNamespace          = 'mail-site2.mikelab.local'
            AutoDiscoverSiteScope      = 'Site2'
            InstantMessagingServerName = 'l15-2.mikelab.local'
            DefaultOAB                 = "Default Offline Address Book (Site2)"
        }
    );
    #endregion
}

Configuration Example
{

    Import-DscResource -Module xExchange

    Node $AllNodes.NodeName
    {
        #Uninstall Jetstress from the computer
        Package UninstallJetstress
        {
            Ensure    = 'Absent'
            Path      = 'C:\Binaries\Jetstress\Jetstress.msi'
            Name      = 'Microsoft Exchange Jetstress 2013 - Uninstall'
            ProductId = '75189587-0D84-4404-8F02-79C39728FA64'
        }

        #Clean up Jetstress databases, mount points, and binaries
        xExchJetstressCleanup CleanupJetstress
        {
            JetstressPath               = 'C:\Program Files\Exchange Jetstress'
            ConfigFilePath              = 'C:\Program Files\Exchange Jetstress\JetstressConfig.xml'
            DeleteAssociatedMountPoints = $true
            OutputSaveLocation          = "$($Node.FileServerBase)\JetstressOutput\$($Node.NodeName)"
            RemoveBinaries              = $true
            DependsOn                   = '[Package]UninstallJetstress'
        }
    }
}
