function Update-ArmorApiToken {
    <#
        .SYNOPSIS
        Retrieves a new authentication token.

        .DESCRIPTION
        Retrieves a new Armor API authentication token and updates the variable storing
        the session details: $Global:ArmorSession.

        .INPUTS
        System.String

        .INPUTS
        System.Management.Automation.PSObject

        .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

        .EXAMPLE
        Update-ArmorApiToken -Token '2261bac252204c2ea93ed32ea1ffd3ab' -ApiVersion 'v1.0'

        .LINK
        https://tlindsay42.github.io/ArmorPowerShell/private/Update-ArmorApiToken/

        .LINK
        https://github.com/tlindsay42/ArmorPowerShell/blob/master/Armor/Private/Update-ArmorApiToken.ps1

        .LINK
        https://docs.armor.com/display/KBSS/Post+Reissue+Token

        .LINK
        https://developer.armor.com/#!/Authentication/TenantOAuth_ReissueAsync

        .COMPONENT
        Armor API

        .FUNCTIONALITY
        Armor session management
    #>

    [CmdletBinding( SupportsShouldProcess = $true, ConfirmImpact = 'Low' )]
    [OutputType( [Void] )]
    param (
        # Specifies the Armor API authorization token.
        [Parameter(
            Position = 0,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateNotNullorEmpty()]
        [String]
        $Token = $Global:ArmorSession.GetToken(),

        # Specifies the API version for this request.
        [Parameter(
            Position = 1,
            ValueFromPipelineByPropertyName = $true
        )]
        [ValidateSet( 'v1.0', 'internal' )]
        [String]
        $ApiVersion = $Global:ArmorSession.ApiVersion
    )

    begin {
        $function = $MyInvocation.MyCommand.Name
        Write-Verbose -Message "Beginning: '${function}'."
    }

    process {
        Write-Verbose -Message (
            "Processing: '${function}' with ParameterSetName '$( $PSCmdlet.ParameterSetName )' and Parameters: " +
            ( $PSBoundParameters | Hide-SensitiveData | Format-Table -AutoSize | Out-String )
        )

        $resources = Get-ArmorApiData -FunctionName $function -ApiVersion $ApiVersion

        $uri = New-ArmorApiUri -Endpoints $resources.Endpoints

        if ( $PSCmdlet.ShouldProcess( $Token, $resources.Description ) ) {
            $keys = ( $resources.Body | Get-Member -MemberType 'NoteProperty' ).Name
            $parameters = ( Get-Command -Name $function ).Parameters.Values
            $body = Format-ArmorApiRequestBody -Keys $keys -Parameters $parameters

            $splat = @{
                Uri         = $uri
                Method      = $resources.Method
                Body        = $body
                SuccessCode = $resources.SuccessCode
            }
            $results = Invoke-ArmorRestMethod @splat

            $Global:ArmorSession.Authorize( $results.Access_Token, $results.Expires_In )
        }
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
