function Get-TargetResource
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSDSCUseVerboseMessageInDSCResource", "")]
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $MailboxServer,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DAGName,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $SkipDagValidation
    )

    LogFunctionEntry -Parameters @{'MailboxServer' = $MailboxServer;'DAGName' = $DAGName} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Get-DatabaseAvailabilityGroup' -VerbosePreference $VerbosePreference

    #Setup params
    AddParameters -PSBoundParametersIn $PSBoundParameters -ParamsToAdd @{'Identity' = $PSBoundParameters['DAGName']}
    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToKeep 'Identity','DomainController'

    $dag = Get-DatabaseAvailabilityGroup @PSBoundParameters -Status -ErrorAction SilentlyContinue

    if ($null -ne $dag -and $null -ne $dag.Servers)
    {
        #See if this server is already in the DAG
        $server = $dag.Servers | Where-Object {$_.Name -eq "$($MailboxServer)"}

        if ($null -ne $server)
        {
            $returnValue = @{
                MailboxServer = $MailboxServer
                DAGName = $dag.Name
            }
        }
    }

    $returnValue
}

function Set-TargetResource
{
    # Suppressing this rule because $global:DSCMachineStatus is used to trigger a reboot.
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidGlobalVars', '')]
    <#
        Suppressing this rule because $global:DSCMachineStatus is only set,
        never used (by design of Desired State Configuration).
    #>
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', '', Scope='Function', Target='DSCMachineStatus')]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSDSCUseVerboseMessageInDSCResource", "")]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $MailboxServer,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DAGName,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $SkipDagValidation
    )

    LogFunctionEntry -Parameters @{'MailboxServer' = $MailboxServer;'DAGName' = $DAGName} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Add-DatabaseAvailabilityGroupServer' -VerbosePreference $VerbosePreference

    #Setup params
    AddParameters -PSBoundParametersIn $PSBoundParameters -ParamsToAdd @{'Identity' = $PSBoundParameters['DAGName']}
    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'DAGName','Credential'

    $failoverClusteringRole = Get-WindowsFeature -Name Failover-Clustering -ErrorAction SilentlyContinue

    #Make sure the Failover-Clustering role is installed before trying to add the member to the DAG
    if ($null -eq $failoverClusteringRole -or !$failoverClusteringRole.Installed)
    {
        Write-Error -Message 'The Failover-Clustering role must be fully installed before the server can be added to the cluster.'
        return
    }
    #Force a reboot if the cluster is in an InstallPending state
    elseif ($failoverClusteringRole.InstallState -like 'InstallPending')
    {
        Write-Warning -Message 'A reboot is required to finish installing the Failover-Clustering role. This must occur before the server can be added to the DAG.'
        $global:DSCMachineStatus = 1
        return
    }

    Add-DatabaseAvailabilityGroupServer @PSBoundParameters
}

function Test-TargetResource
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSDSCUseVerboseMessageInDSCResource", "")]
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $MailboxServer,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(Mandatory = $true)]
        [System.String]
        $DAGName,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $SkipDagValidation
    )

    LogFunctionEntry -Parameters @{'MailboxServer' = $MailboxServer;'DAGName' = $DAGName} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Get-DatabaseAvailabilityGroup' -VerbosePreference $VerbosePreference

    #Setup params
    AddParameters -PSBoundParametersIn $PSBoundParameters -ParamsToAdd @{'Identity' = $PSBoundParameters['DAGName']}
    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToKeep 'Identity','DomainController'

    $dag = Get-DatabaseAvailabilityGroup @PSBoundParameters -Status -ErrorAction SilentlyContinue

    if ($null -ne $dag -and $dag.Name -like "$($DAGName)")
    {
        $server = $dag.Servers | Where-Object {$_.Name -eq "$($MailboxServer)"}

        return ($null -ne $server)
    }

    return $false
}

Export-ModuleMember -Function *-TargetResource
