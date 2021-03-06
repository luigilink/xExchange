<#
    .SYNOPSIS
        Automated integration test for MSFT_xExchMapiVirtualDirectory DSC Resource.
        This test module requires use of credentials.
        The first run through of the tests will prompt for credentials from the logged on user.
#>

#region HEADER
[System.String]$script:moduleRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
[System.String]$script:DSCModuleName = 'xExchange'
[System.String]$script:DSCResourceFriendlyName = 'xExchMapiVirtualDirectory'
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

    Describe 'Test Setting Properties with xExchMapiVirtualDirectory' {
        $testParams = @{
            Identity =  "$($env:COMPUTERNAME)\mapi (Default Web Site)"
            Credential = $Global:ShellCredentials
            ExternalUrl = "https://$($Global:ServerFqdn)/mapi"
            IISAuthenticationMethods = 'Ntlm', 'Oauth', 'Negotiate'
            InternalUrl = "https://$($Global:ServerFqdn)/mapi"                              
        }

        $expectedGetResults = @{
            Identity =  "$($env:COMPUTERNAME)\mapi (Default Web Site)"
            ExternalUrl = "https://$($Global:ServerFqdn)/mapi"
            InternalUrl = "https://$($Global:ServerFqdn)/mapi"   
        }

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Set standard parameters' `
                                         -ExpectedGetResults $expectedGetResults
        
        Test-ArrayContentsEqual -TestParams $testParams `
                                -DesiredArrayContents $testParams.IISAuthenticationMethods `
                                -GetResultParameterName 'IISAuthenticationMethods' `
                                -ContextLabel 'Verify IISAuthenticationMethods' `
                                -ItLabel 'IISAuthenticationMethods should contain three values'

        $testParams = @{
            Identity =  "$($env:COMPUTERNAME)\mapi (Default Web Site)"
            Credential = $Global:ShellCredentials
            ExternalUrl = ''
            IISAuthenticationMethods = 'Ntlm', 'Negotiate'
            InternalUrl = "https://$($Global:ServerFqdn)/mapi"          
        }

        $expectedGetResults = @{
            Identity =  "$($env:COMPUTERNAME)\mapi (Default Web Site)"
            ExternalUrl = $null
            InternalUrl = "https://$($Global:ServerFqdn)/mapi" 
        }

        Test-TargetResourceFunctionality -Params $testParams `
                                         -ContextLabel 'Try with different values' `
                                         -ExpectedGetResults $expectedGetResults
        
        Test-ArrayContentsEqual -TestParams $testParams `
                                -DesiredArrayContents $testParams.IISAuthenticationMethods `
                                -GetResultParameterName 'IISAuthenticationMethods' `
                                -ContextLabel 'Verify IISAuthenticationMethods' `
                                -ItLabel 'IISAuthenticationMethods should contain three values'
    }
}
else
{
    Write-Verbose -Message 'Tests in this file require that Exchange is installed to be run.'
}
