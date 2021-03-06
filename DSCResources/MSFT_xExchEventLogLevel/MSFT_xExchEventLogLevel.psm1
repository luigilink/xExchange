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
        [ValidateSet('Lowest','Low','Medium','High','Expert')]
        [System.String]
        $Level
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Get-EventLogLevel' -VerbosePreference $VerbosePreference

    $eventLogLevel = Get-EventLogLevel -Identity "$($env:COMPUTERNAME)\$($Identity)"

    if ($null -ne $eventLogLevel)
    {
        $returnValue = @{
            Identity = $Identity
            Level = $eventLogLevel.EventLevel
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
        [ValidateSet('Lowest','Low','Medium','High','Expert')]
        [System.String]
        $Level
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Set-EventLogLevel' -VerbosePreference $VerbosePreference

    Set-EventLogLevel -Identity "$($env:COMPUTERNAME)\$($Identity)" -Level $Level
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
        [ValidateSet('Lowest','Low','Medium','High','Expert')]
        [System.String]
        $Level
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Get-EventLogLevel' -VerbosePreference $VerbosePreference

    $eventLogLevel = Get-EventLogLevel -Identity "$($env:COMPUTERNAME)\$($Identity)"

    if ($null -eq $eventLogLevel)
    {
        Write-Error 'Failed to retrieve any objects with specified Identity.'

        return $false
    }
    else
    {
        if (!(VerifySetting -Name 'Level' -Type 'String' -ExpectedValue $Level -ActualValue $eventLogLevel.EventLevel -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
    }

    return $true
}

Export-ModuleMember -Function *-TargetResource
