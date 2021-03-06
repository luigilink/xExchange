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
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        $AlternateServiceAccountCredential,

        [Parameter()]
        [System.String]
        $AutoDiscoverServiceInternalUri,

        [Parameter()]
        [System.String[]]
        $AutoDiscoverSiteScope,

        [Parameter()]
        [System.Boolean]
        $CleanUpInvalidAlternateServiceAccountCredentials,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $RemoveAlternateServiceAccountCredentials
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad "Get-ClientAccessServ*" -VerbosePreference $VerbosePreference

    $cas = GetClientAccessServer @PSBoundParameters

    if ($null -ne $cas)
    {
        if ($null -ne $cas.AutoDiscoverSiteScope)
        {
            $sites = $cas.AutoDiscoverSiteScope.ToArray()
        }
        $returnValue = @{
            Identity = $Identity
            AutoDiscoverServiceInternalUri = $cas.AutoDiscoverServiceInternalUri
            AutoDiscoverSiteScope = $sites
            CleanUpInvalidAlternateServiceAccountCredentials = $CleanUpInvalidAlternateServiceAccountCredentials
            DomainController = $DomainController
            RemoveAlternateServiceAccountCredentials = $RemoveAlternateServiceAccountCredentials
        }
        if ($cas.AlternateServiceAccountConfiguration.EffectiveCredentials.Count -gt 0)
        {
            $UserName = ($cas.AlternateServiceAccountConfiguration.EffectiveCredentials | Sort-Object WhenAddedUTC | Select-Object -Last 1).Credential.UserName
            $PassWord = ($cas.AlternateServiceAccountConfiguration.EffectiveCredentials | Sort-Object WhenAddedUTC | Select-Object -Last 1).Credential.GetNetworkCredential().Password
            $returnValue.Add("AlternateServiceAccountCredential","UserName:$UserName Password:$PassWord")
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

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        $AlternateServiceAccountCredential,

        [Parameter()]
        [System.String]
        $AutoDiscoverServiceInternalUri,

        [Parameter()]
        [System.String[]]
        $AutoDiscoverSiteScope,

        [Parameter()]
        [System.Boolean]
        $CleanUpInvalidAlternateServiceAccountCredentials,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $RemoveAlternateServiceAccountCredentials
    )

    #check for ambiguous parameter
    if (($AlternateServiceAccountCredential -and $RemoveAlternateServiceAccountCredentials) -or ($CleanUpInvalidAlternateServiceAccountCredentials -and $RemoveAlternateServiceAccountCredentials))
    {
        throw "Ambiguous parameter detected! Don't combine AlternateServiceAccountCredential with RemoveAlternateServiceAccountCredentials or CleanUpInvalidAlternateServiceAccountCredentials with RemoveAlternateServiceAccountCredentials!"
    }
    if ($AlternateServiceAccountCredential)
    {
        #check if credentials are in correct format DOMAIN\USERNAME
        $parts = @($AlternateServiceAccountCredential.Username.Split('\'))
        if ($parts.Count -ne 2 -or $parts[0] -eq '')
        {
            throw "The username must be fully qualified!"
        }
    }

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad "Set-ClientAccessServ*" -VerbosePreference $VerbosePreference

    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove "Credential"

    SetEmptyStringParamsToNull -PSBoundParametersIn $PSBoundParameters
    
    $serverVersion = GetExchangeVersion -ThrowIfUnknownVersion $true

    if ($serverVersion -eq "2016")
    {
        Set-ClientAccessService @PSBoundParameters
    }
    elseif ($serverVersion -eq "2013")
    {
        Set-ClientAccessServer @PSBoundParameters
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
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        $AlternateServiceAccountCredential,

        [Parameter()]
        [System.String]
        $AutoDiscoverServiceInternalUri,

        [Parameter()]
        [System.String[]]
        $AutoDiscoverSiteScope,

        [Parameter()]
        [System.Boolean]
        $CleanUpInvalidAlternateServiceAccountCredentials,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $RemoveAlternateServiceAccountCredentials
    )

    LogFunctionEntry -Parameters @{"Identity" = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad "Get-ClientAccessServ*" -VerbosePreference $VerbosePreference

    $cas = GetClientAccessServer @PSBoundParameters

    $serverVersion = GetExchangeVersion -ThrowIfUnknownVersion $true

    if ($null -eq $cas)
    {
        return $false
    }
    else
    {
        if (!(VerifySetting -Name "AutoDiscoverServiceInternalUri" -Type "String" -ExpectedValue $AutoDiscoverServiceInternalUri -ActualValue $cas.AutoDiscoverServiceInternalUri.AbsoluteUri -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name "AutoDiscoverSiteScope" -Type "Array" -ExpectedValue $AutoDiscoverSiteScope -ActualValue $cas.AutoDiscoverSiteScope -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name "AlternateServiceAccountCredential" -Type "PSCredential" -ExpectedValue $AlternateServiceAccountCredential -ActualValue ($cas.AlternateServiceAccountConfiguration.EffectiveCredentials | Sort-Object WhenAddedUTC | Select-Object -Last 1).Credential $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
        if ($CleanUpInvalidAlternateServiceAccountCredentials)
        {
            return $false
        }
        if ($RemoveAlternateServiceAccountCredentials -and ($cas.AlternateServiceAccountConfiguration.EffectiveCredentials.Count -gt 0))
        {
            return $false
        }
    }

    return $true
}

#Runs Get-ClientAcccessServer, only specifying Identity, and optionally DomainController
function GetClientAccessServer
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
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        $AlternateServiceAccountCredential,

        [Parameter()]
        [System.String]
        $AutoDiscoverServiceInternalUri,

        [Parameter()]
        [System.String[]]
        $AutoDiscoverSiteScope,

        [Parameter()]
        [System.Boolean]
        $CleanUpInvalidAlternateServiceAccountCredentials,

        [Parameter()]
        [System.String]
        $DomainController,

        [Parameter()]
        [System.Boolean]
        $RemoveAlternateServiceAccountCredentials
    )

    #Remove params we don't want to pass into the next command
    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToKeep 'Identity','DomainController'

    $serverVersion = GetExchangeVersion -ThrowIfUnknownVersion $true
    if (($null -ne $AlternateServiceAccountCredential) -or ($RemoveAlternateServiceAccountCredentials))
    {
        $PSBoundParameters.Add('IncludeAlternateServiceAccountCredentialPassword',$true)
    }

    if ($serverVersion -eq '2016')
    {
        return (Get-ClientAccessService @PSBoundParameters)
    }
    elseif ($serverVersion -eq '2013')
    {
        return (Get-ClientAccessServer @PSBoundParameters)
    } 
}

Export-ModuleMember -Function *-TargetResource
