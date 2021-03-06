<#
    .SYNOPSIS
        Automated unit integration for MSFT_xExchClientAccessServer DSC Resource.
        This test module requires use of credentials.
        The first run through of the tests will prompt for credentials from the logged on user.
#>

#region HEADER
[System.String]$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
[System.String]$script:DSCModuleName = 'xExchange'
[System.String]$script:DSCResourceFriendlyName = 'xExchClientAccessServer'
[System.String]$script:DSCResourceName = "MSFT_$($script:DSCResourceFriendlyName)"

Import-Module -Name (Join-Path -Path $script:moduleRoot -ChildPath (Join-Path -Path 'Tests' -ChildPath (Join-Path -Path 'TestHelpers' -ChildPath 'xExchangeTestHelper.psm1'))) -Force
Import-Module -Name (Join-Path -Path $script:moduleRoot -ChildPath (Join-Path -Path 'Modules' -ChildPath 'xExchangeHelper.psm1')) -Force
Import-Module -Name (Join-Path -Path $script:moduleRoot -ChildPath (Join-Path -Path 'DSCResources' -ChildPath (Join-Path -Path "$($script:DSCResourceName)" -ChildPath "$($script:DSCResourceName).psm1")))

#Check if Exchange is installed on this machine. If not, we can't run tests
[System.Boolean]$exchangeInstalled = IsSetupComplete

#endregion HEADER

if ($exchangeInstalled)
{
    #Get required credentials to use for the test
    if ($null -eq $Global:ShellCredentials)
    {
        [PSCredential]$Global:ShellCredentials = Get-Credential -Message 'Enter credentials for connecting a Remote PowerShell session to Exchange'
    }

    #Get the Server FQDN for using in URL's
    if ($null -eq $Global:ServerFqdn)
    {
        $Global:ServerFqdn = [System.Net.Dns]::GetHostByName($env:COMPUTERNAME).HostName
    }

    Describe 'Test Setting Properties with xExchClientAccessServer' {        
        #Do standard URL and scope tests
        $testParams = @{
            Identity =  $env:COMPUTERNAME
            Credential = $Global:ShellCredentials
            AutoDiscoverServiceInternalUri = "https://$($Global:ServerFqdn)/autodiscover/autodiscover.xml"
            AutoDiscoverSiteScope = 'Site1'
        }

        $expectedGetResults = @{
            Identity =  $env:COMPUTERNAME
            AutoDiscoverServiceInternalUri = "https://$($Global:ServerFqdn)/autodiscover/autodiscover.xml"
            AutoDiscoverSiteScope = 'Site1'  
        }

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Set autod url and site scope' `
                                         -ExpectedGetResults $expectedGetResults

        #Now set the URL to empty
        $testParams.AutoDiscoverServiceInternalUri = ''
        $expectedGetResults.AutoDiscoverServiceInternalUri = $null

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Set url to empty' `
                                         -ExpectedGetResults $expectedGetResults

        #Now try multiple sites in the site scope
        $testParams.AutoDiscoverSiteScope = 'Site1','Site2'
        $expectedGetResults = @{}

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Set site scope to multi value'`
                                         -ExpectedGetResults $expectedGetResults
        
        Test-ArrayContentsEqual -TestParams $testParams `
                                -DesiredArrayContents $testParams.AutoDiscoverSiteScope `
                                -GetResultParameterName 'AutoDiscoverSiteScope' `
                                -ContextLabel 'Verify AutoDiscoverSiteScope' `
                                -ItLabel 'AutoDiscoverSiteScope should contain two values'

        #Now set the site scope to $null
        $testParams.AutoDiscoverSiteScope = $null
        $expectedGetResults = @{}

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Set site scope to null' `
                                         -ExpectedGetResults $expectedGetResults
        
        Test-ArrayContentsEqual -TestParams $testParams `
                                -DesiredArrayContents $testParams.AutoDiscoverSiteScope `
                                -GetResultParameterName 'AutoDiscoverSiteScope' `
                                -ContextLabel 'Verify AutoDiscoverSiteScope' `
                                -ItLabel 'AutoDiscoverSiteScope should be empty'

        #create ASA credentials
        if ($null -eq $Global:ASACredentials)
        {
            $UserASA = 'Fabrikam\ASA'
            $PWordASA = ConvertTo-SecureString -String 'Pa$$w0rd!' -AsPlainText -Force
            $Global:ASACredentials = New-Object -TypeName System.Management.Automation.PSCredential `
                                                -ArgumentList $UserASA, $PWordASA
        }

        #Now set ASA account
        $testParams.Remove('AutoDiscoverSiteScope')
        $testParams.Remove('AutoDiscoverServiceInternalUri')
        $testParams.Add('AlternateServiceAccountCredential',$Global:ASACredentials)
        $expectedGetResults.Add('AlternateServiceAccountCredential','UserName:Fabrikam\ASA Password:Pa$$w0rd!')
        
        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Set AlternateServiceAccountCredential' `
                                         -ExpectedGetResults $expectedGetResults

        #Test for invalid ASA account format
        Context 'Test looking for invalid format of ASA account' {
            $caughtException = $false
            $UserASA = 'Fabrikam/ASA'
            $PWordASA = ConvertTo-SecureString -String 'Pa$$w0rd!' -AsPlainText -Force
            $Global:ASACredentials = New-Object -TypeName System.Management.Automation.PSCredential `
                                                -ArgumentList $UserASA, $PWordASA
            
            #first clear the current ASA account credentials
            $testParams.Remove('AlternateServiceAccountCredential')
            #add the invalid credentials
            $testParams.Add('AlternateServiceAccountCredential',$Global:ASACredentials)

            try
            {
                $SetResults = Set-TargetResource @testParams
            }
            catch
            {
                $caughtException = $true
            }

            It 'Should hit exception for invalid ASA account format' {
                $caughtException | Should Be $true
            }

            It 'Test results should be false after adding invalid ASA account' {
                $testResults = Test-TargetResource @testParams
                $testResults | Should Be $false
            }
        }

        #Now clear ASA account credentials
        $testParams.Remove('AlternateServiceAccountCredential')
        $testParams.RemoveAlternateServiceAccountCredentials = $true
        $expectedGetResults.Remove('AlternateServiceAccountCredential')

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Clear AlternateServiceAccountCredential' `
                                         -ExpectedGetResults $expectedGetResults
    }
}
else
{
    Write-Verbose -Message 'Tests in this file require that Exchange is installed to be run.'
}
    
