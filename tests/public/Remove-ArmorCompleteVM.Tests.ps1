Import-Module -Name $CI_MODULE_MANIFEST_PATH -Force

$systemUnderTest = ( Split-Path -Leaf $MyInvocation.MyCommand.Path ) -replace '\.Tests\.', '.'

$function = $systemUnderTest.Split( '.' )[0]
$describe = $Global:FORM_FUNCTION_PUBLIC -f $function
Describe -Name $describe -Tag 'Function', 'Public', $function -Fixture {
    #region init
    $help = Get-Help -Name $function -Full

    $Global:ArmorSession = [ArmorSession]::New( 'api.armor.com', 443, 'v1.0' )
    #endregion

    $splat = @{
        ExpectedFunctionName = $function
        FoundFunctionName    = $help.Name
    }
    Test-AdvancedFunctionName @splat

    Test-AdvancedFunctionHelpMain -Help $help

    Test-AdvancedFunctionHelpInput -Help $help

    $splat = @{
        ExpectedOutputTypeNames = 'ArmorVM', 'ArmorVM[]'
        Help                    = $help
    }
    Test-AdvancedFunctionHelpOutput @splat

    $splat = @{
        ExpectedParameterNames = 'ID', 'IsActive', 'DeleteNow', 'AccountID', 'UserName', 'ApiVersion', 'WhatIf', 'Confirm'
        Help                   = $help
    }
    Test-AdvancedFunctionHelpParameter @splat

    $splat = @{
        ExpectedNotes = $Global:FORM_FUNCTION_HELP_NOTES
        Help          = $help
    }
    Test-AdvancedFunctionHelpNote @splat

    Context -Name $Global:EXECUTION -Fixture {
        InModuleScope -ModuleName $Global:CI_MODULE_NAME -ScriptBlock {
            #region init
            $invalidID = 0
            $validID = 1
            $invalidUserName = 'invalid@example.tld'
            $invalidApiVersion = 'v0.0'
            $validApiVersion = 'v1.0'
            $Global:ArmorSession = [ArmorSession]::New()
            $Global:ArmorSession.User = [ArmorSessionUser] @{ UserName = 'valid@example.tld' }
            $Global:ArmorSession.Accounts = [ArmorAccount] @{ ID = 1 }, [ArmorAccount] @{ ID = 2 }
            #endregion

            $testCases = @(
                @{
                    ID         = $invalidID
                    IsActive   = $false
                    DeleteNow  = $false
                    AccountID  = $validID
                    UserName   = $Global:ArmorSession.User.UserName
                    ApiVersion = $validApiVersion
                },
                @{
                    ID         = $validID
                    IsActive   = $null
                    DeleteNow  = $false
                    AccountID  = $validID
                    UserName   = $Global:ArmorSession.User.UserName
                    ApiVersion = $validApiVersion
                },
                @{
                    ID         = $validID
                    IsActive   = $true
                    DeleteNow  = $null
                    AccountID  = $validID
                    UserName   = $Global:ArmorSession.User.UserName
                    ApiVersion = $validApiVersion
                },
                @{
                    ID         = $validID
                    IsActive   = $false
                    DeleteNow  = $true
                    AccountID  = $invalidID
                    UserName   = $Global:ArmorSession.User.UserName
                    ApiVersion = $validApiVersion
                },
                @{
                    ID         = $validID
                    IsActive   = $false
                    DeleteNow  = $false
                    AccountID  = $validID
                    UserName   = $invalidUserName
                    ApiVersion = $validApiVersion
                },
                @{
                    ID         = $validID
                    IsActive   = $false
                    DeleteNow  = $true
                    AccountID  = $validID
                    UserName   = $Global:ArmorSession.User.UserName
                    ApiVersion = $invalidApiVersion
                }
            )
            $testName = 'should fail when set to: ID: <ID>, IsActive: <IsActive>, DeleteNow: <DeleteNow>, AccountID: <AccountID>, UserName: <UserName> ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [UInt16] $ID, [PSObject] $IsActive, [PSObject] $DeleteNow, [UInt16] $AccountID, [String] $UserName, [String] $ApiVersion )
                { Remove-ArmorCompleteVM -ID $ID -IsActive:$IsActive -DeleteNow:$DeleteNow -AccountID $AccountID -UserName $UserName -ApiVersion $ApiVersion -Confirm:$false } |
                    Should -Throw
            }

            Mock -CommandName Assert-ArmorSession -Verifiable -MockWith {}
            Mock -CommandName Invoke-WebRequest -Verifiable -MockWith {
                @{
                    StatusCode        = 202
                    StatusDescription = 'Accepted'
                    Content           = $Global:JSON_RESPONSE_BODY.VMs1
                }
            }

            $testCases = @(
                @{
                    ID         = $validID
                    IsActive   = $false
                    DeleteNow  = $true
                    AccountID  = $validID
                    UserName   = $Global:ArmorSession.User.UserName
                    ApiVersion = $validApiVersion
                }
            )
            $testName = 'should not fail when set to: ID: <ID>, ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [UInt16] $ID, [PSObject] $IsActive, [PSObject] $DeleteNow, [UInt16] $AccountID, [String] $UserName, [String] $ApiVersion )
                { Remove-ArmorCompleteVM -ID $ID -IsActive:$IsActive -DeleteNow:$DeleteNow -AccountID $AccountID -UserName $UserName -ApiVersion $ApiVersion -Confirm:$false } |
                    Should -Not -Throw
            }
            Assert-VerifiableMock
            Assert-MockCalled -CommandName Assert-ArmorSession -Times $testCases.Count
            Assert-MockCalled -CommandName Invoke-WebRequest -Times $testCases.Count
        }
    }

    Context -Name $Global:RETURN_TYPE_CONTEXT -Fixture {
        InModuleScope -ModuleName $Global:CI_MODULE_NAME -ScriptBlock {
            #region init
            $Global:ArmorSession = [ArmorSession]::New()
            $Global:ArmorSession.User = [ArmorSessionUser] @{ UserName = 'valid@example.tld' }
            $Global:ArmorSession.Accounts = [ArmorAccount] @{ ID = 1 }
            $Global:ArmorSession.SetAccountContext( 1 )
            #endregion

            Mock -CommandName Assert-ArmorSession -Verifiable -MockWith {}
            Mock -CommandName Invoke-WebRequest -Verifiable -MockWith {
                @{
                    StatusCode        = 202
                    StatusDescription = 'Accepted'
                    Content           = $Global:JSON_RESPONSE_BODY.VMs1
                }
            }

            $testCases = @(
                @{
                    FoundReturnType    = ( Remove-ArmorCompleteVM -ID 1 -Confirm:$false -ErrorAction 'Stop' ).GetType().FullName
                    ExpectedReturnType = 'ArmorVM'
                }
            )
            $testName = $Global:FORM_RETURN_TYPE
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $FoundReturnType, [String] $ExpectedReturnType )
                $FoundReturnType |
                    Should -Be $ExpectedReturnType
            }
            Assert-VerifiableMock
            Assert-MockCalled -CommandName Assert-ArmorSession -Times $testCases.Count
            Assert-MockCalled -CommandName Invoke-WebRequest -Times $testCases.Count

            $testName = "has an 'OutputType' entry for <FoundReturnType>"
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $FoundReturnType, [String] $ExpectedReturnType )
                $FoundReturnType |
                    Should -BeIn ( Get-Help -Name 'Remove-ArmorCompleteVM' -Full ).ReturnValues.ReturnValue.Type.Name
            }
        }
    }
}
