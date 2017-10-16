Function New-ArmorApiToken
{
	<#
		.SYNOPSIS
		Creates an authentication token from an authorization code.

		.DESCRIPTION
		{ required: more detailed description of the function's purpose }

		.NOTES
		Troy Lindsay
		Twitter: @troylindsay42
		GitHub: tlindsay42

		.PARAMETER Code
		The temporary authorization code to redeem for a token.

		.PARAMETER GrantType
		The type of permission.

		.PARAMETER ApiVersion
		The API version.

		.INPUTS
		System.String
			New-ArmorApiToken accepts the temporary authorization code via the pipeline.

		.OUTPUTS
		System.Collections.Hashtable
			New-ArmorApiToken returns a hashtable with the contents of the response body of the token request.

		.LINK
		https://github.com/tlindsay42/ArmorPowerShell

		.LINK
		https://docs.armor.com/display/KBSS/Armor+API+Guide

		.LINK
		https://developer.armor.com/

		.EXAMPLE
		New-ArmorApiToken -Code 'HJTX3gAAAAN2q1UP7cvFtOh1qffrfWIpKetdnIgvOfpJRSC5W7b3vVqMBn8pZHtRY8I4nLRzW95gdWPdRMVUrgsnJ2mwqB8kgxOu8lhH1LOggfwrRCvxLGvGmwET59gIzJ60rxpEdM0dTLw58kNnWVbaQI1NmPQJwjvD/1RIPTnOL5d+z29wyJ/BI/POlPKNlVfHsJGYJl8ql0/3D3czNGhXCqfV20Uj0r8EX7zsQz/9t1YCqKKj9OpPv3sypXS6h4hNb/v4yLD33G+EnwOajJQ62sA='
	#>

	[CmdletBinding()]
	Param
	(
		[Parameter( ValueFromPipeline = $true, Position = 0 )]
		[ValidateNotNullorEmpty()]
		[String] $Code = $null,
		[Parameter( Position = 1 )]
		[ValidateSet( 'authorization_code' )]
		[String] $GrantType = 'authorization_code',
		[Parameter( Position = 2 )]
		[ValidateSet( 'v1.0' )]
		[String] $ApiVersion = 'v1.0'
	)

	Begin
	{
		# The Begin section is used to perform one-time loads of data necessary to carry out the function's purpose
		# If a command needs to be run with each iteration or pipeline input, place it in the Process section

		# API data references the name of the function
		# For convenience, that name is saved here to $function
		$function = $MyInvocation.MyCommand.Name

		Write-Verbose -Message ( 'Beginning {0}.' -f $function )
	} # End of Begin

	Process
	{
		# Retrieve all of the URI, method, body, query, result, filter, and success details for the API endpoint
		Write-Verbose -Message ( 'Gather API Data for {0}.' -f $function )

		$resources = Get-ArmorApiData -Endpoint $function -ApiVersion $ApiVersion

		$uri = New-ArmorApiUriString -Endpoint $resources.Uri

		$body = Format-ArmorApiJsonRequestBody -BodyKeys $resources.Body.Keys -Parameters ( Get-Command -Name $function ).Parameters.Values

		$result = Submit-ArmorApiRequest -Uri $uri -Header $headers -Method $resources.Method -Body $body

		$result = Format-ArmorApiResult -Result $result -Location $resources.Location

		$result = Select-ArmorApiResult -Result $result -Filter $resources.Filter

		Return $result
	} # End of Process

	End
	{
		Write-Verbose -Message ( 'Ending {0}.' -f $function )
	}
} # End of Function
