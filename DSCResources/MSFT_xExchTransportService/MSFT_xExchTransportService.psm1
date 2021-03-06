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
        $ActiveUserStatisticsLogMaxAge,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogPath,

        [Parameter()]
        [System.Boolean]
        $AgentLogEnabled,

        [Parameter()]
        [System.String]
        $AgentLogMaxAge,

        [Parameter()]
        [System.String]
        $AgentLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $AgentLogMaxFileSize,

        [Parameter()]
        [System.String]
        $AgentLogPath,

        [Parameter()]
        [System.Boolean]
        $ConnectivityLogEnabled,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxAge,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ConnectivityLogPath,

        [Parameter()]
        [System.Boolean]
        $ContentConversionTracingEnabled,

        [Parameter()]
        [System.String]
        $DelayNotificationTimeout,

        [Parameter()]
        [System.Boolean]
        $DnsLogEnabled,

        [Parameter()]
        [System.String]
        $DnsLogMaxAge,

        [Parameter()]
        [System.String]
        $DnsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $DnsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $DnsLogPath,

        [Parameter()]
        [System.Boolean]
        $ExternalDNSAdapterEnabled,

        [Parameter()]
        [System.String]
        $ExternalDNSAdapterGuid,

        [Parameter()]
        [ValidateSet('Any','UseTcpOnly','UseUdpOnly')]
        [System.String]
        $ExternalDNSProtocolOption,

        [Parameter()]
        [System.String[]]
        $ExternalDNSServers,

        [Parameter()]
        [System.String]
        $ExternalIPAddress,

        [Parameter()]
        [System.Boolean]
        $InternalDNSAdapterEnabled,

        [Parameter()]
        [System.String]
        $InternalDNSAdapterGuid,

        [Parameter()]
        [ValidateSet('Any','UseTcpOnly','UseUdpOnly')]
        [System.String]
        $InternalDNSProtocolOption,

        [Parameter()]
        [System.String[]]
        $InternalDNSServers,

        [Parameter()]
        [ValidateSet('None','Verbose')]
        [System.String]
        $IntraOrgConnectorProtocolLoggingLevel,

        [Parameter()]
        [System.Int32]
        $IntraOrgConnectorSmtpMaxMessagesPerConnection,

        [Parameter()]
        [System.Boolean]
        $IrmLogEnabled,

        [Parameter()]
        [System.String]
        $IrmLogMaxAge,

        [Parameter()]
        [System.String]
        $IrmLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $IrmLogMaxFileSize,

        [Parameter()]
        [System.String]
        $IrmLogPath,

        [Parameter()]
        [System.Int32]
        $MaxConcurrentMailboxDeliveries,

        [Parameter()]
        [System.Int32]
        $MaxConcurrentMailboxSubmissions,

        [Parameter()]
        [System.Int32]
        $MaxConnectionRatePerMinute,

        [Parameter()]
        [ValidateRange(1,2147483647)]
        [System.String]
        $MaxOutboundConnections,

        [Parameter()]
        [ValidateRange(1,2147483647)]
        [System.String]
        $MaxPerDomainOutboundConnections,

        [Parameter()]
        [System.String]
        $MessageExpirationTimeout,

        [Parameter()]
        [System.String]
        $MessageRetryInterval,

        [Parameter()]
        [System.Boolean]
        $MessageTrackingLogEnabled,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxAge,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxFileSize,

        [Parameter()]
        [System.String]
        $MessageTrackingLogPath,

        [Parameter()]
        [System.Boolean]
        $MessageTrackingLogSubjectLoggingEnabled,

        [Parameter()]
        [System.String]
        $OutboundConnectionFailureRetryInterval,

        [Parameter()]
        [System.String]
        $PickupDirectoryMaxHeaderSize,

        [Parameter()]
        [ValidateRange(1,20000)]
        [System.Int32]
        $PickupDirectoryMaxMessagesPerMinute,

        [Parameter()]
        [ValidateRange(1,10000)]
        [System.Int32]
        $PickupDirectoryMaxRecipientsPerMessage,

        [Parameter()]
        [System.String]
        $PickupDirectoryPath,

        [Parameter()]
        [System.Boolean]
        $PipelineTracingEnabled,

        [Parameter()]
        [System.String]
        $PipelineTracingPath,

        [Parameter()]
        [System.String]
        $PipelineTracingSenderAddress,

        [Parameter()]
        [System.Boolean]
        $PoisonMessageDetectionEnabled,

        [Parameter()]
        [ValidateRange(1,10)]
        [System.Int32]
        $PoisonThreshold,

        [Parameter()]
        [System.String]
        $QueueLogMaxAge,

        [Parameter()]
        [System.String]
        $QueueLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $QueueLogMaxFileSize,

        [Parameter()]
        [System.String]
        $QueueLogPath,

        [Parameter()]
        [System.String]
        $QueueMaxIdleTime,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxAge,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogPath,

        [Parameter()]
        [System.Boolean]
        $RecipientValidationCacheEnabled,

        [Parameter()]
        [System.String]
        $ReplayDirectoryPath,

        [Parameter()]
        [System.String]
        $RootDropDirectoryPath,

        [Parameter()]
        [System.String]
        $RoutingTableLogMaxAge,

        [Parameter()]
        [System.String]
        $RoutingTableLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $RoutingTableLogPath,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxAge,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxFileSize,

        [Parameter()]
        [System.String]
        $SendProtocolLogPath,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxAge,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogPath,

        [Parameter()]
        [ValidateRange(1,15)]
        [System.Int32]
        $TransientFailureRetryCount,

        [Parameter()]
        [System.String]
        $TransientFailureRetryInterval,

        [Parameter()]
        [System.Boolean]
        $UseDowngradedExchangeServerAuth
    )

    LogFunctionEntry -Parameters @{'Identity' = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Get-TransportService' -VerbosePreference $VerbosePreference

    #Remove Credential and Ensure so we don't pass it into the next command
    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'Credential','AllowServiceRestart'

    $TransportService = Get-TransportService $Identity -ErrorAction SilentlyContinue
    if ($null -ne $TransportService)
    {
        $returnValue = @{
            Identity                                        = $Identity
            ActiveUserStatisticsLogMaxAge                   = $TransportService.ActiveUserStatisticsLogMaxAge
            ActiveUserStatisticsLogMaxDirectorySize         = $TransportService.ActiveUserStatisticsLogMaxDirectorySize
            ActiveUserStatisticsLogMaxFileSize              = $TransportService.ActiveUserStatisticsLogMaxFileSize
            ActiveUserStatisticsLogPath                     = $TransportService.ActiveUserStatisticsLogPath
            AgentLogEnabled                                 = $TransportService.AgentLogEnabled
            AgentLogMaxAge                                  = $TransportService.AgentLogMaxAge
            AgentLogMaxDirectorySize                        = $TransportService.AgentLogMaxDirectorySize
            AgentLogMaxFileSize                             = $TransportService.AgentLogMaxFileSize
            AgentLogPath                                    = $TransportService.AgentLogPath
            ConnectivityLogEnabled                          = $TransportService.ConnectivityLogEnabled
            ConnectivityLogMaxAge                           = $TransportService.ConnectivityLogMaxAge
            ConnectivityLogMaxDirectorySize                 = $TransportService.ConnectivityLogMaxDirectorySize
            ConnectivityLogMaxFileSize                      = $TransportService.ConnectivityLogMaxFileSize
            ConnectivityLogPath                             = $TransportService.ConnectivityLogPath
            ContentConversionTracingEnabled                 = $TransportService.ContentConversionTracingEnabled
            DelayNotificationTimeout                        = $TransportService.DelayNotificationTimeout
            DnsLogEnabled                                   = $TransportService.DnsLogEnabled
            DnsLogMaxAge                                    = $TransportService.DnsLogMaxAge
            DnsLogMaxDirectorySize                          = $TransportService.DnsLogMaxDirectorySize
            DnsLogMaxFileSize                               = $TransportService.DnsLogMaxFileSize
            DnsLogPath                                      = $TransportService.DnsLogPath
            ExternalDNSAdapterEnabled                       = $TransportService.ExternalDNSAdapterEnabled
            ExternalDNSAdapterGuid                          = $TransportService.ExternalDNSAdapterGuid
            ExternalDNSProtocolOption                       = $TransportService.ExternalDNSProtocolOption
            ExternalDNSServers                              = $TransportService.ExternalDNSServers.IPAddressToString
            ExternalIPAddress                               = $TransportService.ExternalIPAddress
            InternalDNSAdapterEnabled                       = $TransportService.InternalDNSAdapterEnabled
            InternalDNSAdapterGuid                          = $TransportService.InternalDNSAdapterGuid
            InternalDNSProtocolOption                       = $TransportService.InternalDNSProtocolOption
            InternalDNSServers                              = $TransportService.InternalDNSServers.IPAddressToString
            IntraOrgConnectorProtocolLoggingLevel           = $TransportService.IntraOrgConnectorProtocolLoggingLevel
            IntraOrgConnectorSmtpMaxMessagesPerConnection   = $TransportService.IntraOrgConnectorSmtpMaxMessagesPerConnection
            IrmLogEnabled                                   = $TransportService.IrmLogEnabled
            IrmLogMaxAge                                    = $TransportService.IrmLogMaxAge
            IrmLogMaxDirectorySize                          = $TransportService.IrmLogMaxDirectorySize
            IrmLogMaxFileSize                               = $TransportService.IrmLogMaxFileSize
            IrmLogPath                                      = $TransportService.IrmLogPath
            MaxConcurrentMailboxDeliveries                  = $TransportService.MaxConcurrentMailboxDeliveries
            MaxConcurrentMailboxSubmissions                 = $TransportService.MaxConcurrentMailboxSubmissions
            MaxConnectionRatePerMinute                      = $TransportService.MaxConnectionRatePerMinute
            MaxOutboundConnections                          = $TransportService.MaxOutboundConnections
            MaxPerDomainOutboundConnections                 = $TransportService.MaxPerDomainOutboundConnections
            MessageExpirationTimeout                        = $TransportService.MessageExpirationTimeout
            MessageRetryInterval                            = $TransportService.MessageRetryInterval
            MessageTrackingLogEnabled                       = $TransportService.MessageTrackingLogEnabled
            MessageTrackingLogMaxAge                        = $TransportService.MessageTrackingLogMaxAge
            MessageTrackingLogMaxDirectorySize              = $TransportService.MessageTrackingLogMaxDirectorySize
            MessageTrackingLogMaxFileSize                   = $TransportService.MessageTrackingLogMaxFileSize
            MessageTrackingLogPath                          = $TransportService.MessageTrackingLogPath
            MessageTrackingLogSubjectLoggingEnabled         = $TransportService.MessageTrackingLogSubjectLoggingEnabled
            OutboundConnectionFailureRetryInterval          = $TransportService.OutboundConnectionFailureRetryInterval
            PickupDirectoryMaxHeaderSize                    = $TransportService.PickupDirectoryMaxHeaderSize
            PickupDirectoryMaxMessagesPerMinute             = $TransportService.PickupDirectoryMaxMessagesPerMinute
            PickupDirectoryMaxRecipientsPerMessage          = $TransportService.PickupDirectoryMaxRecipientsPerMessage
            PickupDirectoryPath                             = $TransportService.PickupDirectoryPath
            PipelineTracingEnabled                          = $TransportService.PipelineTracingEnabled
            PipelineTracingPath                             = $TransportService.PipelineTracingPath
            PipelineTracingSenderAddress                    = $TransportService.PipelineTracingSenderAddress
            PoisonMessageDetectionEnabled                   = $TransportService.PoisonMessageDetectionEnabled
            PoisonThreshold                                 = $TransportService.PoisonThreshold
            QueueLogMaxAge                                  = $TransportService.QueueLogMaxAge
            QueueLogMaxDirectorySize                        = $TransportService.QueueLogMaxDirectorySize
            QueueLogMaxFileSize                             = $TransportService.QueueLogMaxFileSize
            QueueLogPath                                    = $TransportService.QueueLogPath
            QueueMaxIdleTime                                = $TransportService.QueueMaxIdleTime
            ReceiveProtocolLogMaxAge                        = $TransportService.ReceiveProtocolLogMaxAge
            ReceiveProtocolLogMaxDirectorySize              = $TransportService.ReceiveProtocolLogMaxDirectorySize
            ReceiveProtocolLogMaxFileSize                   = $TransportService.ReceiveProtocolLogMaxFileSize
            ReceiveProtocolLogPath                          = $TransportService.ReceiveProtocolLogPath
            RecipientValidationCacheEnabled                 = $TransportService.RecipientValidationCacheEnabled
            ReplayDirectoryPath                             = $TransportService.ReplayDirectoryPath
            RootDropDirectoryPath                           = $TransportService.RootDropDirectoryPath
            RoutingTableLogMaxAge                           = $TransportService.RoutingTableLogMaxAge
            RoutingTableLogMaxDirectorySize                 = $TransportService.RoutingTableLogMaxDirectorySize
            RoutingTableLogPath                             = $TransportService.RoutingTableLogPath
            SendProtocolLogMaxAge                           = $TransportService.SendProtocolLogMaxAge
            SendProtocolLogMaxDirectorySize                 = $TransportService.SendProtocolLogMaxDirectorySize
            SendProtocolLogMaxFileSize                      = $TransportService.SendProtocolLogMaxFileSize
            SendProtocolLogPath                             = $TransportService.SendProtocolLogPath
            ServerStatisticsLogMaxAge                       = $TransportService.ServerStatisticsLogMaxAge
            ServerStatisticsLogMaxDirectorySize             = $TransportService.ServerStatisticsLogMaxDirectorySize
            ServerStatisticsLogMaxFileSize                  = $TransportService.ServerStatisticsLogMaxFileSize
            ServerStatisticsLogPath                         = $TransportService.ServerStatisticsLogPath
            TransientFailureRetryCount                      = $TransportService.TransientFailureRetryCount
            TransientFailureRetryInterval                   = $TransportService.TransientFailureRetryInterval.ToString()
            UseDowngradedExchangeServerAuth                 = $TransportService.UseDowngradedExchangeServerAuth
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
        $ActiveUserStatisticsLogMaxAge,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogPath,

        [Parameter()]
        [System.Boolean]
        $AgentLogEnabled,

        [Parameter()]
        [System.String]
        $AgentLogMaxAge,

        [Parameter()]
        [System.String]
        $AgentLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $AgentLogMaxFileSize,

        [Parameter()]
        [System.String]
        $AgentLogPath,

        [Parameter()]
        [System.Boolean]
        $ConnectivityLogEnabled,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxAge,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ConnectivityLogPath,

        [Parameter()]
        [System.Boolean]
        $ContentConversionTracingEnabled,

        [Parameter()]
        [System.String]
        $DelayNotificationTimeout,

        [Parameter()]
        [System.Boolean]
        $DnsLogEnabled,

        [Parameter()]
        [System.String]
        $DnsLogMaxAge,

        [Parameter()]
        [System.String]
        $DnsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $DnsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $DnsLogPath,

        [Parameter()]
        [System.Boolean]
        $ExternalDNSAdapterEnabled,

        [Parameter()]
        [System.String]
        $ExternalDNSAdapterGuid,

        [Parameter()]
        [ValidateSet('Any','UseTcpOnly','UseUdpOnly')]
        [System.String]
        $ExternalDNSProtocolOption,

        [Parameter()]
        [System.String[]]
        $ExternalDNSServers,

        [Parameter()]
        [System.String]
        $ExternalIPAddress,

        [Parameter()]
        [System.Boolean]
        $InternalDNSAdapterEnabled,

        [Parameter()]
        [System.String]
        $InternalDNSAdapterGuid,

        [Parameter()]
        [ValidateSet('Any','UseTcpOnly','UseUdpOnly')]
        [System.String]
        $InternalDNSProtocolOption,

        [Parameter()]
        [System.String[]]
        $InternalDNSServers,

        [Parameter()]
        [ValidateSet('None','Verbose')]
        [System.String]
        $IntraOrgConnectorProtocolLoggingLevel,

        [Parameter()]
        [System.Int32]
        $IntraOrgConnectorSmtpMaxMessagesPerConnection,

        [Parameter()]
        [System.Boolean]
        $IrmLogEnabled,

        [Parameter()]
        [System.String]
        $IrmLogMaxAge,

        [Parameter()]
        [System.String]
        $IrmLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $IrmLogMaxFileSize,

        [Parameter()]
        [System.String]
        $IrmLogPath,

        [Parameter()]
        [System.Int32]
        $MaxConcurrentMailboxDeliveries,

        [Parameter()]
        [System.Int32]
        $MaxConcurrentMailboxSubmissions,

        [Parameter()]
        [System.Int32]
        $MaxConnectionRatePerMinute,

        [Parameter()]
        [ValidateRange(1,2147483647)]
        [System.String]
        $MaxOutboundConnections,

        [Parameter()]
        [ValidateRange(1,2147483647)]
        [System.String]
        $MaxPerDomainOutboundConnections,

        [Parameter()]
        [System.String]
        $MessageExpirationTimeout,

        [Parameter()]
        [System.String]
        $MessageRetryInterval,

        [Parameter()]
        [System.Boolean]
        $MessageTrackingLogEnabled,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxAge,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxFileSize,

        [Parameter()]
        [System.String]
        $MessageTrackingLogPath,

        [Parameter()]
        [System.Boolean]
        $MessageTrackingLogSubjectLoggingEnabled,

        [Parameter()]
        [System.String]
        $OutboundConnectionFailureRetryInterval,

        [Parameter()]
        [System.String]
        $PickupDirectoryMaxHeaderSize,

        [Parameter()]
        [ValidateRange(1,20000)]
        [System.Int32]
        $PickupDirectoryMaxMessagesPerMinute,

        [Parameter()]
        [ValidateRange(1,10000)]
        [System.Int32]
        $PickupDirectoryMaxRecipientsPerMessage,

        [Parameter()]
        [System.String]
        $PickupDirectoryPath,

        [Parameter()]
        [System.Boolean]
        $PipelineTracingEnabled,

        [Parameter()]
        [System.String]
        $PipelineTracingPath,

        [Parameter()]
        [System.String]
        $PipelineTracingSenderAddress,

        [Parameter()]
        [System.Boolean]
        $PoisonMessageDetectionEnabled,

        [Parameter()]
        [ValidateRange(1,10)]
        [System.Int32]
        $PoisonThreshold,

        [Parameter()]
        [System.String]
        $QueueLogMaxAge,

        [Parameter()]
        [System.String]
        $QueueLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $QueueLogMaxFileSize,

        [Parameter()]
        [System.String]
        $QueueLogPath,

        [Parameter()]
        [System.String]
        $QueueMaxIdleTime,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxAge,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogPath,

        [Parameter()]
        [System.Boolean]
        $RecipientValidationCacheEnabled,

        [Parameter()]
        [System.String]
        $ReplayDirectoryPath,

        [Parameter()]
        [System.String]
        $RootDropDirectoryPath,

        [Parameter()]
        [System.String]
        $RoutingTableLogMaxAge,

        [Parameter()]
        [System.String]
        $RoutingTableLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $RoutingTableLogPath,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxAge,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxFileSize,

        [Parameter()]
        [System.String]
        $SendProtocolLogPath,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxAge,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogPath,

        [Parameter()]
        [ValidateRange(1,15)]
        [System.Int32]
        $TransientFailureRetryCount,

        [Parameter()]
        [System.String]
        $TransientFailureRetryInterval,

        [Parameter()]
        [System.Boolean]
        $UseDowngradedExchangeServerAuth
    )

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Set-TransportService' -VerbosePreference $VerbosePreference

    #Remove Credential and Ensure so we don't pass it into the next command
    RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'Credential','AllowServiceRestart'

    try
    {
        #if PipelineTracingSenderAddress exists and is $null remove it from $PSBoundParameters and add argument
        if ($PSBoundParameters.ContainsKey('PipelineTracingSenderAddress'))
        {
            if ([System.String]::IsNullOrEmpty($PipelineTracingSenderAddress))
            {
                Write-Verbose -Message 'PipelineTracingSenderAddress is NULL'
                RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'PipelineTracingSenderAddress'
                $PSBoundParameters['PipelineTracingSenderAddress'] = $null
            }
        }

        #if ExternalIPAddress exists and is $null remove it from $PSBoundParameters and add argument
        if ($PSBoundParameters.ContainsKey('ExternalIPAddress'))
        {
            if ([System.String]::IsNullOrEmpty($ExternalIPAddress))
            {
                Write-Verbose -Message 'ExternalIPAddress is NULL'
                RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'ExternalIPAddress'
                $PSBoundParameters['ExternalIPAddress'] = $null
            }
        }

        #if InternalDNSServers exists and is $null remove it from $PSBoundParameters and add argument
        if ($PSBoundParameters.ContainsKey('InternalDNSServers'))
        {
            if ([System.String]::IsNullOrEmpty($InternalDNSServers))
            {
                Write-Verbose -Message 'InternalDNSServers is NULL'
                RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'InternalDNSServers'
                $PSBoundParameters['InternalDNSServers'] = $null
            }
        }

        #if ExternalDNSServers exists and is $null remove it from $PSBoundParameters and add argument
        if ($PSBoundParameters.ContainsKey('ExternalDNSServers'))
        {
            if ([System.String]::IsNullOrEmpty($ExternalDNSServers))
            {
                Write-Verbose -Message 'ExternalDNSServers is NULL'
                RemoveParameters -PSBoundParametersIn $PSBoundParameters -ParamsToRemove 'ExternalDNSServers'
                $PSBoundParameters['ExternalDNSServers'] = $null
            }
        }

        Set-TransportService @PSBoundParameters
    }
    catch
    {
        Write-Verbose -Message "The following exception was thrown:$($_.Exception.Message)"
    }
    
    if ($AllowServiceRestart -eq $true)
    {
        Write-Verbose -Message 'Restart service MSExchangeTransport'
        Restart-Service -Name MSExchangeTransport -WarningAction SilentlyContinue
    }
    Else
    {
        Write-Warning -Message 'The configuration will not take effect until the MSExchangeTransport service is manually restarted.'
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
        $ActiveUserStatisticsLogMaxAge,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ActiveUserStatisticsLogPath,

        [Parameter()]
        [System.Boolean]
        $AgentLogEnabled,

        [Parameter()]
        [System.String]
        $AgentLogMaxAge,

        [Parameter()]
        [System.String]
        $AgentLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $AgentLogMaxFileSize,

        [Parameter()]
        [System.String]
        $AgentLogPath,

        [Parameter()]
        [System.Boolean]
        $ConnectivityLogEnabled,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxAge,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ConnectivityLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ConnectivityLogPath,

        [Parameter()]
        [System.Boolean]
        $ContentConversionTracingEnabled,

        [Parameter()]
        [System.String]
        $DelayNotificationTimeout,

        [Parameter()]
        [System.Boolean]
        $DnsLogEnabled,

        [Parameter()]
        [System.String]
        $DnsLogMaxAge,

        [Parameter()]
        [System.String]
        $DnsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $DnsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $DnsLogPath,

        [Parameter()]
        [System.Boolean]
        $ExternalDNSAdapterEnabled,

        [Parameter()]
        [System.String]
        $ExternalDNSAdapterGuid,

        [Parameter()]
        [ValidateSet('Any','UseTcpOnly','UseUdpOnly')]
        [System.String]
        $ExternalDNSProtocolOption,

        [Parameter()]
        [System.String[]]
        $ExternalDNSServers,

        [Parameter()]
        [System.String]
        $ExternalIPAddress,

        [Parameter()]
        [System.Boolean]
        $InternalDNSAdapterEnabled,

        [Parameter()]
        [System.String]
        $InternalDNSAdapterGuid,

        [Parameter()]
        [ValidateSet('Any','UseTcpOnly','UseUdpOnly')]
        [System.String]
        $InternalDNSProtocolOption,

        [Parameter()]
        [System.String[]]
        $InternalDNSServers,

        [Parameter()]
        [ValidateSet('None','Verbose')]
        [System.String]
        $IntraOrgConnectorProtocolLoggingLevel,

        [Parameter()]
        [System.Int32]
        $IntraOrgConnectorSmtpMaxMessagesPerConnection,

        [Parameter()]
        [System.Boolean]
        $IrmLogEnabled,

        [Parameter()]
        [System.String]
        $IrmLogMaxAge,

        [Parameter()]
        [System.String]
        $IrmLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $IrmLogMaxFileSize,

        [Parameter()]
        [System.String]
        $IrmLogPath,

        [Parameter()]
        [System.Int32]
        $MaxConcurrentMailboxDeliveries,

        [Parameter()]
        [System.Int32]
        $MaxConcurrentMailboxSubmissions,

        [Parameter()]
        [System.Int32]
        $MaxConnectionRatePerMinute,

        [Parameter()]
        [ValidateRange(1,2147483647)]
        [System.String]
        $MaxOutboundConnections,

        [Parameter()]
        [ValidateRange(1,2147483647)]
        [System.String]
        $MaxPerDomainOutboundConnections,

        [Parameter()]
        [System.String]
        $MessageExpirationTimeout,

        [Parameter()]
        [System.String]
        $MessageRetryInterval,

        [Parameter()]
        [System.Boolean]
        $MessageTrackingLogEnabled,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxAge,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $MessageTrackingLogMaxFileSize,

        [Parameter()]
        [System.String]
        $MessageTrackingLogPath,

        [Parameter()]
        [System.Boolean]
        $MessageTrackingLogSubjectLoggingEnabled,

        [Parameter()]
        [System.String]
        $OutboundConnectionFailureRetryInterval,

        [Parameter()]
        [System.String]
        $PickupDirectoryMaxHeaderSize,

        [Parameter()]
        [ValidateRange(1,20000)]
        [System.Int32]
        $PickupDirectoryMaxMessagesPerMinute,

        [Parameter()]
        [ValidateRange(1,10000)]
        [System.Int32]
        $PickupDirectoryMaxRecipientsPerMessage,

        [Parameter()]
        [System.String]
        $PickupDirectoryPath,

        [Parameter()]
        [System.Boolean]
        $PipelineTracingEnabled,

        [Parameter()]
        [System.String]
        $PipelineTracingPath,

        [Parameter()]
        [System.String]
        $PipelineTracingSenderAddress,

        [Parameter()]
        [System.Boolean]
        $PoisonMessageDetectionEnabled,

        [Parameter()]
        [ValidateRange(1,10)]
        [System.Int32]
        $PoisonThreshold,

        [Parameter()]
        [System.String]
        $QueueLogMaxAge,

        [Parameter()]
        [System.String]
        $QueueLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $QueueLogMaxFileSize,

        [Parameter()]
        [System.String]
        $QueueLogPath,

        [Parameter()]
        [System.String]
        $QueueMaxIdleTime,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxAge,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ReceiveProtocolLogPath,

        [Parameter()]
        [System.Boolean]
        $RecipientValidationCacheEnabled,

        [Parameter()]
        [System.String]
        $ReplayDirectoryPath,

        [Parameter()]
        [System.String]
        $RootDropDirectoryPath,

        [Parameter()]
        [System.String]
        $RoutingTableLogMaxAge,

        [Parameter()]
        [System.String]
        $RoutingTableLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $RoutingTableLogPath,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxAge,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $SendProtocolLogMaxFileSize,

        [Parameter()]
        [System.String]
        $SendProtocolLogPath,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxAge,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxDirectorySize,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogMaxFileSize,

        [Parameter()]
        [System.String]
        $ServerStatisticsLogPath,

        [Parameter()]
        [ValidateRange(1,15)]
        [System.Int32]
        $TransientFailureRetryCount,

        [Parameter()]
        [System.String]
        $TransientFailureRetryInterval,

        [Parameter()]
        [System.Boolean]
        $UseDowngradedExchangeServerAuth
    )

    LogFunctionEntry -Parameters @{'Identity' = $Identity} -VerbosePreference $VerbosePreference

    #Establish remote Powershell session
    GetRemoteExchangeSession -Credential $Credential -CommandsToLoad 'Get-TransportService' -VerbosePreference $VerbosePreference

    $TransportService = Get-TransportService $Identity -ErrorAction SilentlyContinue

    if ($null -ne $TransportService)
    {
        if (!(VerifySetting -Name 'ActiveUserStatisticsLogMaxAge' -Type 'Timespan' -ExpectedValue $ActiveUserStatisticsLogMaxAge -ActualValue $TransportService.ActiveUserStatisticsLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ActiveUserStatisticsLogMaxDirectorySize' -Type 'ByteQuantifiedSize' -ExpectedValue $ActiveUserStatisticsLogMaxDirectorySize -ActualValue $TransportService.ActiveUserStatisticsLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ActiveUserStatisticsLogMaxFileSize' -Type 'ByteQuantifiedSize' -ExpectedValue $ActiveUserStatisticsLogMaxFileSize -ActualValue $TransportService.ActiveUserStatisticsLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }   

        if (!(VerifySetting -Name 'ActiveUserStatisticsLogPath' -Type 'String' -ExpectedValue $ActiveUserStatisticsLogPath -ActualValue $TransportService.ActiveUserStatisticsLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }   

        if (!(VerifySetting -Name 'AgentLogEnabled' -Type 'Boolean' -ExpectedValue $AgentLogEnabled -ActualValue $TransportService.AgentLogEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'AgentLogMaxAge' -Type 'Timespan' -ExpectedValue $AgentLogMaxAge -ActualValue $TransportService.AgentLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'AgentLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $AgentLogMaxDirectorySize -ActualValue $TransportService.AgentLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'AgentLogMaxFileSize' -Type 'Unlimited' -ExpectedValue $AgentLogMaxFileSize -ActualValue $TransportService.AgentLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'AgentLogPath' -Type 'String' -ExpectedValue $AgentLogPath -ActualValue $TransportService.AgentLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ConnectivityLogEnabled' -Type 'Boolean' -ExpectedValue $ConnectivityLogEnabled -ActualValue $TransportService.ConnectivityLogEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ConnectivityLogMaxAge' -Type 'Timespan' -ExpectedValue $ConnectivityLogMaxAge -ActualValue $TransportService.ConnectivityLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ConnectivityLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $ConnectivityLogMaxDirectorySize -ActualValue $TransportService.ConnectivityLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ConnectivityLogMaxFileSize' -Type 'Unlimited' -ExpectedValue $ConnectivityLogMaxFileSize -ActualValue $TransportService.ConnectivityLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ConnectivityLogPath' -Type 'String' -ExpectedValue $ConnectivityLogPath -ActualValue $TransportService.ConnectivityLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ContentConversionTracingEnabled' -Type 'Boolean' -ExpectedValue $ContentConversionTracingEnabled -ActualValue $TransportService.ContentConversionTracingEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'DelayNotificationTimeout' -Type 'TimeSpan' -ExpectedValue $DelayNotificationTimeout -ActualValue $TransportService.DelayNotificationTimeout -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'DnsLogEnabled' -Type 'Boolean' -ExpectedValue $DnsLogEnabled -ActualValue $TransportService.DnsLogEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'DnsLogMaxAge' -Type 'TimeSpan' -ExpectedValue $DnsLogMaxAge -ActualValue $TransportService.DnsLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'DnsLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $DnsLogMaxDirectorySize -ActualValue $TransportService.DnsLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'DnsLogMaxFileSize' -Type 'Unlimited' -ExpectedValue $DnsLogMaxFileSize -ActualValue $TransportService.DnsLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'DnsLogPath' -Type 'String' -ExpectedValue $DnsLogPath -ActualValue $TransportService.DnsLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ExternalDNSAdapterEnabled' -Type 'Boolean' -ExpectedValue $ExternalDNSAdapterEnabled -ActualValue $TransportService.ExternalDNSAdapterEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ExternalDNSAdapterGuid' -Type 'String' -ExpectedValue $ExternalDNSAdapterGuid -ActualValue $TransportService.ExternalDNSAdapterGuid -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
 
        if (!(VerifySetting -Name 'ExternalDNSProtocolOption' -Type 'String' -ExpectedValue $ExternalDNSProtocolOption -ActualValue $TransportService.ExternalDNSProtocolOption -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ExternalDNSServers' -Type 'IPAddresses' -ExpectedValue $ExternalDNSServers -ActualValue $TransportService.ExternalDNSServers.IPAddressToString -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ExternalIPAddress' -Type 'IPAddress' -ExpectedValue $ExternalIPAddress -ActualValue $TransportService.ExternalIPAddress -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'InternalDNSAdapterEnabled' -Type 'Boolean' -ExpectedValue $InternalDNSAdapterEnabled -ActualValue $TransportService.InternalDNSAdapterEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'InternalDNSAdapterGuid' -Type 'String' -ExpectedValue $InternalDNSAdapterGuid -ActualValue $TransportService.InternalDNSAdapterGuid -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'InternalDNSProtocolOption' -Type 'String' -ExpectedValue $InternalDNSProtocolOption -ActualValue $TransportService.InternalDNSProtocolOption -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'InternalDNSServers' -Type 'IPAddresses' -ExpectedValue $InternalDNSServers -ActualValue $TransportService.InternalDNSServers.IPAddressToString -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IntraOrgConnectorProtocolLoggingLevel' -Type 'String' -ExpectedValue $IntraOrgConnectorProtocolLoggingLevel -ActualValue $TransportService.IntraOrgConnectorProtocolLoggingLevel -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IntraOrgConnectorSmtpMaxMessagesPerConnection' -Type 'Int' -ExpectedValue $IntraOrgConnectorSmtpMaxMessagesPerConnection -ActualValue $TransportService.IntraOrgConnectorSmtpMaxMessagesPerConnection -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IrmLogEnabled' -Type 'Boolean' -ExpectedValue $IrmLogEnabled -ActualValue $TransportService.IrmLogEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IrmLogMaxAge' -Type 'TimeSpan' -ExpectedValue $IrmLogMaxAge -ActualValue $TransportService.IrmLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IrmLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $IrmLogMaxDirectorySize -ActualValue $TransportService.IrmLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IrmLogMaxFileSize' -Type 'ByteQuantifiedSize' -ExpectedValue $IrmLogMaxFileSize -ActualValue $TransportService.IrmLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'IrmLogPath' -Type 'String' -ExpectedValue $IrmLogPath -ActualValue $TransportService.IrmLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MaxConcurrentMailboxDeliveries' -Type 'Int' -ExpectedValue $MaxConcurrentMailboxDeliveries -ActualValue $TransportService.MaxConcurrentMailboxDeliveries -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MaxConcurrentMailboxSubmissions' -Type 'Int' -ExpectedValue $MaxConcurrentMailboxSubmissions -ActualValue $TransportService.MaxConcurrentMailboxSubmissions -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MaxConnectionRatePerMinute' -Type 'Int' -ExpectedValue $MaxConnectionRatePerMinute -ActualValue $TransportService.MaxConnectionRatePerMinute -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MaxOutboundConnections' -Type 'Unlimited' -ExpectedValue $MaxOutboundConnections -ActualValue $TransportService.MaxOutboundConnections -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MaxPerDomainOutboundConnections' -Type 'Unlimited' -ExpectedValue $MaxPerDomainOutboundConnections -ActualValue $TransportService.MaxPerDomainOutboundConnections -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageExpirationTimeout' -Type 'TimeSpan' -ExpectedValue $MessageExpirationTimeout -ActualValue $TransportService.MessageExpirationTimeout -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageRetryInterval' -Type 'TimeSpan' -ExpectedValue $MessageRetryInterval -ActualValue $TransportService.MessageRetryInterval -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageTrackingLogEnabled' -Type 'Boolean' -ExpectedValue $MessageTrackingLogEnabled -ActualValue $TransportService.MessageTrackingLogEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageTrackingLogMaxAge' -Type 'TimeSpan' -ExpectedValue $MessageTrackingLogMaxAge -ActualValue $TransportService.MessageTrackingLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageTrackingLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $MessageTrackingLogMaxDirectorySize -ActualValue $TransportService.MessageTrackingLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageTrackingLogMaxFileSize' -Type 'ByteQuantifiedSize' -ExpectedValue $MessageTrackingLogMaxFileSize -ActualValue $TransportService.MessageTrackingLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageTrackingLogPath' -Type 'String' -ExpectedValue $MessageTrackingLogPath -ActualValue $TransportService.MessageTrackingLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'MessageTrackingLogSubjectLoggingEnabled' -Type 'Boolean' -ExpectedValue $MessageTrackingLogSubjectLoggingEnabled -ActualValue $TransportService.MessageTrackingLogSubjectLoggingEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'OutboundConnectionFailureRetryInterval' -Type 'TimeSpan' -ExpectedValue $OutboundConnectionFailureRetryInterval -ActualValue $TransportService.OutboundConnectionFailureRetryInterval -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PickupDirectoryMaxHeaderSize' -Type 'ByteQuantifiedSize' -ExpectedValue $PickupDirectoryMaxHeaderSize -ActualValue $TransportService.PickupDirectoryMaxHeaderSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PickupDirectoryMaxMessagesPerMinute' -Type 'Int' -ExpectedValue $PickupDirectoryMaxMessagesPerMinute -ActualValue $TransportService.PickupDirectoryMaxMessagesPerMinute -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PickupDirectoryMaxRecipientsPerMessage' -Type 'Int' -ExpectedValue $PickupDirectoryMaxRecipientsPerMessage -ActualValue $TransportService.PickupDirectoryMaxRecipientsPerMessage -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
        
        if (!(VerifySetting -Name 'PickupDirectoryPath' -Type 'String' -ExpectedValue $PickupDirectoryPath -ActualValue $TransportService.PickupDirectoryPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PipelineTracingEnabled' -Type 'Boolean' -ExpectedValue $PipelineTracingEnabled -ActualValue $TransportService.PipelineTracingEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PipelineTracingPath' -Type 'String' -ExpectedValue $PipelineTracingPath -ActualValue $TransportService.PipelineTracingPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }


        if (!(VerifySetting -Name 'PipelineTracingSenderAddress' -Type 'SMTPAddress' -ExpectedValue $PipelineTracingSenderAddress -ActualValue $TransportService.PipelineTracingSenderAddress -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PoisonMessageDetectionEnabled' -Type 'Boolean' -ExpectedValue $PoisonMessageDetectionEnabled -ActualValue $TransportService.PoisonMessageDetectionEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'PoisonThreshold' -Type 'Int' -ExpectedValue $PoisonThreshold -ActualValue $TransportService.PoisonThreshold -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'QueueLogMaxAge' -Type 'TimeSpan' -ExpectedValue $QueueLogMaxAge -ActualValue $TransportService.QueueLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'QueueLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $QueueLogMaxDirectorySize -ActualValue $TransportService.QueueLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'QueueLogMaxFileSize' -Type 'Unlimited' -ExpectedValue $QueueLogMaxFileSize -ActualValue $TransportService.QueueLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'QueueLogPath' -Type 'String' -ExpectedValue $QueueLogPath -ActualValue $TransportService.QueueLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'QueueMaxIdleTime' -Type 'TimeSpan' -ExpectedValue $QueueMaxIdleTime -ActualValue $TransportService.QueueMaxIdleTime -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ReceiveProtocolLogMaxAge' -Type 'TimeSpan' -ExpectedValue $ReceiveProtocolLogMaxAge -ActualValue $TransportService.ReceiveProtocolLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ReceiveProtocolLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $ReceiveProtocolLogMaxDirectorySize -ActualValue $TransportService.ReceiveProtocolLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ReceiveProtocolLogMaxFileSize' -Type 'Unlimited' -ExpectedValue $ReceiveProtocolLogMaxFileSize -ActualValue $TransportService.ReceiveProtocolLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ReceiveProtocolLogPath' -Type 'String' -ExpectedValue $ReceiveProtocolLogPath -ActualValue $TransportService.ReceiveProtocolLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'RecipientValidationCacheEnabled' -Type 'Boolean' -ExpectedValue $RecipientValidationCacheEnabled -ActualValue $TransportService.RecipientValidationCacheEnabled -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }
        if (!(VerifySetting -Name 'ReplayDirectoryPath' -Type 'String' -ExpectedValue $ReplayDirectoryPath -ActualValue $TransportService.ReplayDirectoryPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'RootDropDirectoryPath' -Type 'String' -ExpectedValue $RootDropDirectoryPath -ActualValue $TransportService.RootDropDirectoryPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'RoutingTableLogMaxAge' -Type 'TimeSpan' -ExpectedValue $RoutingTableLogMaxAge -ActualValue $TransportService.RoutingTableLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'RoutingTableLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $RoutingTableLogMaxDirectorySize -ActualValue $TransportService.RoutingTableLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'RoutingTableLogPath' -Type 'String' -ExpectedValue $RoutingTableLogPath -ActualValue $TransportService.RoutingTableLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'SendProtocolLogMaxAge' -Type 'TimeSpan' -ExpectedValue $SendProtocolLogMaxAge -ActualValue $TransportService.SendProtocolLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'SendProtocolLogMaxDirectorySize' -Type 'Unlimited' -ExpectedValue $SendProtocolLogMaxDirectorySize -ActualValue $TransportService.SendProtocolLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'SendProtocolLogMaxFileSize' -Type 'Unlimited' -ExpectedValue $SendProtocolLogMaxFileSize -ActualValue $TransportService.SendProtocolLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'SendProtocolLogPath' -Type 'String' -ExpectedValue $SendProtocolLogPath -ActualValue $TransportService.SendProtocolLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ServerStatisticsLogMaxAge' -Type 'TimeSpan' -ExpectedValue $ServerStatisticsLogMaxAge -ActualValue $TransportService.ServerStatisticsLogMaxAge -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ServerStatisticsLogMaxDirectorySize' -Type 'ByteQuantifiedSize' -ExpectedValue $ServerStatisticsLogMaxDirectorySize -ActualValue $TransportService.ServerStatisticsLogMaxDirectorySize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ServerStatisticsLogMaxFileSize' -Type 'ByteQuantifiedSize' -ExpectedValue $ServerStatisticsLogMaxFileSize -ActualValue $TransportService.ServerStatisticsLogMaxFileSize -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'ServerStatisticsLogPath' -Type 'String' -ExpectedValue $ServerStatisticsLogPath -ActualValue $TransportService.ServerStatisticsLogPath -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'TransientFailureRetryCount' -Type 'Int' -ExpectedValue $TransientFailureRetryCount -ActualValue $TransportService.TransientFailureRetryCount -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'TransientFailureRetryInterval' -Type 'TimeSpan' -ExpectedValue $TransientFailureRetryInterval -ActualValue $TransportService.TransientFailureRetryInterval -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

        if (!(VerifySetting -Name 'UseDowngradedExchangeServerAuth' -Type 'Boolean' -ExpectedValue $UseDowngradedExchangeServerAuth -ActualValue $TransportService.UseDowngradedExchangeServerAuth -PSBoundParametersIn $PSBoundParameters -VerbosePreference $VerbosePreference))
        {
            return $false
        }

    }
    else
    {
        return $false
    }
    return $true
}

function CompareIPAddressewithString
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter()]
        [System.Net.IPAddress]
        $IPAddress,
        
        [Parameter()]
        [System.String]
        $String
    )

    if (($null -eq $IPAddress -and !([System.String]::IsNullOrEmpty($String))) -or ($null -ne $IPAddress -and [System.String]::IsNullOrEmpty($String)))
    {
        $returnValue = $false
    }
    elseif ($null -eq $IPAddress -and [System.String]::IsNullOrEmpty($String))
    {
        $returnValue = $true
    }
    else
    {
        $returnValue =($IPAddress.Equals([System.Net.IPAddress]::Parse($string)))
    }
    
    if ($returnValue -eq $false)
    {
        ReportBadSetting -SettingName $IPAddress -ExpectedValue $ExpectedValue -ActualValue $IPAddress -VerbosePreference $VerbosePreference
    }
    return $returnValue
}

function CompareSmtpAdresswithString
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param
    (
        [Parameter()]
        $SmtpAddress,
        
        [Parameter()]
        [System.String]
        $String
    )
    
    if (($null -eq $SmtpAddress) -and ([System.String]::IsNullOrEmpty($String)))
    {
        Write-Verbose -Message 'Expected and actual value is empty, therefore equal!'
        return $true
    }
    elseif (($null -eq $SmtpAddress) -and -not ([System.String]::IsNullOrEmpty($String)))
    {
        return $false
    }
    elseif ($SmtpAddress.Gettype() -eq [Microsoft.Exchange.Data.SmtpAddress])
    {
        if ([System.String]::IsNullOrEmpty($String))
        {
            return $false
        }
        else
        {
            return($SmtpAddress.Equals([Microsoft.Exchange.Data.SmtpAddress]::Parse($string)))
        }
    }
    else
    {
        Write-Verbose -Message 'No type of [Microsoft.Exchange.Data.SmtpAddress]!'
        return $false
    }
}

Export-ModuleMember -Function *-TargetResource
