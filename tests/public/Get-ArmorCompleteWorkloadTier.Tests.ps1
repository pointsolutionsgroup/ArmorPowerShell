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
        ExpectedOutputTypeNames = 'ArmorCompleteWorkloadTier', 'ArmorCompleteWorkloadTier[]'
        Help                    = $help
    }
    Test-AdvancedFunctionHelpOutput @splat

    $splat = @{
        ExpectedParameterNames = 'WorkloadID', 'ID', 'Name', 'ApiVersion'
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
            $invalidName = ''
            $validName = 'TR1'
            $invalidApiVersion = 'v0.0'
            $validApiVersion = 'v1.0'
            #endregion

            $testCases = @(
                @{
                    WorkloadID = $invalidID
                    ID         = $validID
                    ApiVersion = $validApiVersion
                },
                @{
                    WorkloadID = $validID
                    ID         = $invalidID
                    ApiVersion = $validApiVersion
                },
                @{
                    WorkloadID = $validID
                    ID         = $validID
                    ApiVersion = $invalidApiVersion
                }
            )
            $testName = 'should fail when set to: WorkloadID: <WorkloadID>, ID: <ID>, ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $WorkloadID, [String] $ID, [String] $ApiVersion )
                { Get-ArmorCompleteWorkloadTier -WorkloadID $WorkloadID -ID $ID -ApiVersion $ApiVersion } |
                    Should -Throw
            }

            $testCases = @(
                @{
                    WorkloadID = $invalidID
                    Name       = $validName
                    ApiVersion = $validApiVersion
                },
                @{
                    WorkloadID = $validID
                    Name       = $invalidName
                    ApiVersion = $validApiVersion
                },
                @{
                    WorkloadID = $validID
                    Name       = $validName
                    ApiVersion = $invalidApiVersion
                }
            )
            $testName = 'should fail when set to: WorkloadID: <WorkloadID>, Name: <Name>, ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $WorkloadID, [String] $Name, [String] $ApiVersion )
                { Get-ArmorCompleteWorkloadTier -WorkloadID $WorkloadID -Name $Name -ApiVersion $ApiVersion -ErrorAction 'Stop' } |
                    Should -Throw
            }

            Mock -CommandName Assert-ArmorSession -Verifiable -MockWith {}
            Mock -CommandName Invoke-WebRequest -Verifiable -MockWith {
                @{
                    StatusCode        = 200
                    StatusDescription = 'OK'
                    Content           = $Global:JSON_RESPONSE_BODY.Tiers1VMs1
                }
            }

            $testCases = @(
                @{
                    WorkloadID = $validID
                    Name       = 'Garbage'
                    ApiVersion = $validApiVersion
                }
            )
            $testName = 'should fail when set to: WorkloadID: <WorkloadID>, Name: <Name>, ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $WorkloadID, [String] $Name, [String] $ApiVersion )
                { Get-ArmorCompleteWorkloadTier -WorkloadID $WorkloadID -Name $Name -ApiVersion $ApiVersion -ErrorAction 'Stop' } |
                    Should -Throw
            }
            Assert-VerifiableMock
            Assert-MockCalled -CommandName Assert-ArmorSession -Times $testCases.Count
            Assert-MockCalled -CommandName Invoke-WebRequest -Times $testCases.Count

            $testCases = @(
                @{
                    WorkloadID = $validID
                    ID         = $validID
                    ApiVersion = $validApiVersion
                }
            )
            $testName = 'should not fail when set to: WorkloadID: <WorkloadID>, ID: <ID>, ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $WorkloadID, [String] $ID, [String] $ApiVersion )
                { Get-ArmorCompleteWorkloadTier -WorkloadID $WorkloadID -ID $ID -ApiVersion $ApiVersion } |
                    Should -Not -Throw
            }
            Assert-VerifiableMock
            Assert-MockCalled -CommandName Assert-ArmorSession -Times $testCases.Count
            Assert-MockCalled -CommandName Invoke-WebRequest -Times $testCases.Count

            $testCases = @(
                @{
                    WorkloadID = $validID
                    Name       = $validName
                    ApiVersion = $validApiVersion
                }
            )
            $testName = 'should not fail when set to: WorkloadID: <WorkloadID>, Name: <Name>, ApiVersion: <ApiVersion>'
            It -Name $testName -TestCases $testCases -Test {
                param ( [String] $WorkloadID, [String] $Name, [String] $ApiVersion )
                { Get-ArmorCompleteWorkloadTier -WorkloadID $WorkloadID -Name $Name -ApiVersion $ApiVersion } |
                    Should -Not -Throw
            }
            Assert-VerifiableMock
            Assert-MockCalled -CommandName Assert-ArmorSession -Times $testCases.Count
            Assert-MockCalled -CommandName Invoke-WebRequest -Times $testCases.Count
        }
    }

    Context -Name $Global:RETURN_TYPE_CONTEXT -Fixture {
        InModuleScope -ModuleName $Global:CI_MODULE_NAME -ScriptBlock {
            Mock -CommandName Assert-ArmorSession -Verifiable -MockWith {}
            Mock -CommandName Invoke-WebRequest -Verifiable -MockWith {
                @{
                    StatusCode        = 200
                    StatusDescription = 'OK'
                    Content           = $Global:JSON_RESPONSE_BODY.Tiers1VMs1
                }
            }

            $testCases = @(
                @{
                    FoundReturnType    = ( Get-ArmorCompleteWorkloadTier -WorkloadID 1 -ID 1 -ErrorAction 'Stop' ).GetType().FullName
                    ExpectedReturnType = 'ArmorCompleteWorkloadTier'
                },
                @{
                    FoundReturnType    = ( Get-ArmorCompleteWorkloadTier -WorkloadID 1 -Name 'TR1' -ErrorAction 'Stop' ).GetType().FullName
                    ExpectedReturnType = 'ArmorCompleteWorkloadTier'
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
                    Should -BeIn ( Get-Help -Name 'Get-ArmorCompleteWorkloadTier' -Full ).ReturnValues.ReturnValue.Type.Name
            }
        }
    }
}
