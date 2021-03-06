function Add-ArmorApiUriQuery {
    <#
        .SYNOPSIS
        Builds the Armor API URI with one or more server-side filters.

        .DESCRIPTION
        Builds a server-side filtering URL with a query string if there are any
        parameter names or aliases specified in the calling cmdlet that match
        the filter keys in the `Query` key.

        .INPUTS
        None
            You cannot pipe input to this cmdlet.

        .NOTES
        - Troy Lindsay
        - Twitter: @troylindsay42
        - GitHub: tlindsay42

        .EXAMPLE
        $keys = ( $resources.Query | Get-Member -MemberType 'NoteProperty' ).Name; Add-ArmorApiUriQuery -Keys $keys; $parameters = ( Get-Command -Name $function ).Parameters.Values; Add-ArmorApiUriQuery -Keys $keys -Parameters $parameters -Uri 'https://api.armor.com/vms'
        This is not a real example, but if valid, it would return the input URI with a
        'Name' server-side filter (eg: https://api.armor.com/vms?name=TEST-VM)

        .LINK
        https://tlindsay42.github.io/ArmorPowerShell/private/Add-ArmorApiUriQuery/

        .LINK
        https://github.com/tlindsay42/ArmorPowerShell/blob/master/Armor/Private/Add-ArmorApiUriQuery.ps1

        .LINK
        https://docs.armor.com/display/KBSS/Armor+API+Guide

        .LINK
        https://developer.armor.com/

        .COMPONENT
        Armor API

        .FUNCTIONALITY
        Armor API server-side request filtering
    #>

    [CmdletBinding( SupportsShouldProcess = $true, ConfirmImpact = 'Low' )]
    [OutputType( [String] )]
    param (
        # Specifies the query filters available to the endpoint.
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [AllowEmptyCollection()]
        [AllowNull()]
        [String[]]
        $Keys,

        # Specifies the parameters available within the calling cmdlet.
        [Parameter(
            Mandatory = $true,
            Position = 1
        )]
        [ValidateCount( 1, 65535 )]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject[]]
        $Parameters,

        # Specifies the endpoint's URI.
        [Parameter(
            Mandatory = $true,
            Position = 2
        )]
        [ValidateScript( { $_ -match 'https://.+/\w+' } )]
        [String]
        $Uri
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

        [String] $return = $Uri

        if ( $PSCmdlet.ShouldProcess( 'Add the server-side URI query filter' ) ) {
            Write-Verbose -Message 'Build the query parameters.'

            $queryString = @()

            <#
            Walk through all of the available query options presented by the
            endpoint.

            Note: Keys are used to search in case the value changes in the future
            across different API versions.
            #>
            foreach ( $key in $Keys ) {
                <#
                Walk through all of the parameters defined in the function.  Both
                the parameter name and parameter alias are used to match against a
                query option.   It is suggested to make the parameter name "human
                friendly" and set an alias corresponding to the query option name.
                #>
                foreach ( $parameter in $Parameters ) {
                    $parameterValue = ( Get-Variable -Name $parameter.Name ).Value

                    <#
                    If the parameter name matches the query option name or one of
                    its aliases, build a query string.
                    #>
                    if ( $parameter.Name -eq $key -or $parameter.Aliases -contains $key ) {
                        if ( $parameterValue.Length -gt 0 ) {
                            $queryString += $key + '=' + $parameterValue
                        }
                        else {
                            Write-Verbose -Message "Parameter: '$( $parameter.Name )' = `$null"
                        }
                    }
                }
            }

            <#
        After all query options are exhausted, build a new URI with all defined
        query options.
        #>
            if ( $queryString.Count -gt 0 ) {
                $return += '?' + ( $queryString -join '&' )

                Write-Verbose -Message "URI = ${return}"
            }
        }

        $return
    }

    end {
        Write-Verbose -Message "Ending: '${function}'."
    }
}
