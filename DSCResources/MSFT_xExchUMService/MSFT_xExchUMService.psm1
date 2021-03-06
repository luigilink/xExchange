function Get-TargetResource
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSDSCUseVerboseMessageInDSCResource", "")]
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP','TLS','Dual')]
        [System.String]
        $UMStartupMode,
        
        [Parameter()]
        [System.String[]]
        $DialPlans,
        
        [Parameter()]
        [System.String]
        $DomainController
    )

    LogFunctionEntry -Parameters @{'Identity' = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad '*UMService' -VerbosePreference $VerbosePreference

    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToKeep 'Identity','DomainController'

    $umService = Get-UMService @PSBoundParameters

    if ($null -ne $umService)
    {
        $returnValue = @{
            Identity = $Identity
            UMStartupMode = $umService.UMStartupMode
            DialPlans = $umService.DialPlans.Name
        }
    }

    $returnValue
}

function Set-TargetResource
{
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSDSCUseVerboseMessageInDSCResource", "")]
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory = $true)]
        [System.String]
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP','TLS','Dual')]
        [System.String]
        $UMStartupMode,
                
        [Parameter()]
        [System.String[]]
        $DialPlans,

        [Parameter()]
        [System.String]
        $DomainController
    )

    LogFunctionEntry -Parameters @{'Identity' = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad '*UMService' -VerbosePreference $VerbosePreference

    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'Credential'

    Set-UMService @PSBoundParameters
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
        $Identity,

        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateSet('TCP','TLS','Dual')]
        [System.String]
        $UMStartupMode,
        
        [Parameter()]
        [System.String[]]
        $DialPlans,
        
        [Parameter()]
        [System.String]
        $DomainController
    )

    LogFunctionEntry -Parameters @{'Identity' = $Identity} -VerbosePreference $VerbosePreference


    $umService = Get-TargetResource @PSBoundParameters

    if ($null -eq $umService)
    {
        return $false
    }
    else
    {
        if (!(VerifySetting -Name 'UMStartupMode' -Type 'String' -ExpectedValue $UMStartupMode -ActualValue $umService.UMStartupMode -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
        if (!(VerifySetting -Name 'DialPlans' -Type 'Array' -ExpectedValue $DialPlans -ActualValue $umService.DialPlans -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
    }

    return $true
}

Export-ModuleMember -Function *-TargetResource
