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

        [Parameter()]
        [System.Boolean]
        $AllowServiceRestart = $false,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.String]
        $ExternalUrl,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $IISAuthenticationMethods,

        [Parameter()]
        [System.String]
        $InternalUrl
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad "Get-MapiVirtualDirectory" -VerbosePreference $VerbosePreference

    $vdir = GetMapiVirtualDirectory @PSBoundParameters

    if ($null -ne $vdir)
    {
        $returnValue = @{
            Identity = $Identity
            IISAuthenticationMethods = $vdir.IISAuthenticationMethods
            ExternalUrl = $vdir.ExternalUrl.AbsoluteUri
            InternalUrl = $vdir.InternalUrl.AbsoluteUri
        }
    }

    $returnValue
}

function Set-TargetResource
{
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

        [Parameter()]
        [System.Boolean]
        $AllowServiceRestart = $false,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.String]
        $ExternalUrl,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $IISAuthenticationMethods,

        [Parameter()]
        [System.String]
        $InternalUrl
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad "Set-MapiVirtualDirectory" -VerbosePreference $VerbosePreference

    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove "Credential","AllowServiceRestart"

    SetEmptyStringParamsToNull -PSBoundParametersIn $PSBoundParameters

    Set-MapiVirtualDirectory @PSBoundParameters

    if ($AllowServiceRestart -eq $true)
    {
        Write-Verbose "Recycling MSExchangeMapiFrontEndAppPool and MSExchangeMapiMailboxAppPool"

        RestartAppPoolIfExists -Name MSExchangeMapiFrontEndAppPool
        RestartAppPoolIfExists -Name MSExchangeMapiMailboxAppPool
    }
    else
    {
        Write-Warning "The configuration will not take effect until MSExchangeMapiFrontEndAppPool and MSExchangeMapiMailboxAppPool are manually recycled."
    }
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

        [Parameter()]
        [System.Boolean]
        $AllowServiceRestart = $false,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.String]
        $ExternalUrl,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $IISAuthenticationMethods,

        [Parameter()]
        [System.String]
        $InternalUrl
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad "Get-MapiVirtualDirectory" -VerbosePreference $VerbosePreference

    $vdir = GetMapiVirtualDirectory @PSBoundParameters

    if ($null -eq $vdir)
    {
        return $false
    }
    else
    {
        if (!(VerifySetting -Name "IISAuthenticationMethods" -Type "Array" -ExpectedValue $IISAuthenticationMethods -ActualValue $vdir.IISAuthenticationMethods -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name "ExternalUrl" -Type "String" -ExpectedValue $ExternalUrl -ActualValue $vdir.ExternalUrl.AbsoluteUri -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name "InternalUrl" -Type "String" -ExpectedValue $InternalUrl -ActualValue $vdir.InternalUrl.AbsoluteUri -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }    
    }
    
    return $true
}

function GetMapiVirtualDirectory
{
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

        [Parameter()]
        [System.Boolean]
        $AllowServiceRestart = $false,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.String]
        $ExternalUrl,

        [Parameter(Mandatory = $true)]
        [System.String[]]
        $IISAuthenticationMethods,

        [Parameter()]
        [System.String]
        $InternalUrl
    )

    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToKeep "Identity","DomainController"

    return (Get-MapiVirtualDirectory @PSBoundParameters)
}

Export-ModuleMember -Function *-TargetResource
