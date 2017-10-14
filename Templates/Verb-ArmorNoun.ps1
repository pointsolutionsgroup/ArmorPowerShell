Function Verb-ArmorNoun
{
	<#
		.SYNOPSIS
		{ required: high level overview }

		.DESCRIPTION
		{ required: more detailed description of the function's purpose }

		.NOTES
		Written by { required }
		Twitter: { optional }
		GitHub: { optional }
		Any other links you'd like here

		.PARAMETER Parameter
		{ required: description of the specified input parameter's purpose }

		.INPUTS
		{ required: .NET Framework object types that can be piped in and a description of the input objects }

		.OUTPUTS
		{ required: .NET Framework object types that the cmdlet returns and a description of the returned objects }

		.LINK
		https://github.com/tlindsay42/ArmorPowerShell

		.LINK
		https://docs.armor.com/display/KBSS/Armor+API+Guide

		.LINK
		https://developer.armor.com/

		.EXAMPLE
		{required: show one or more examples using the function}
	#>

	[CmdletBinding()]
	Param
	(
		[String] $Param1,
		[String] $Param2,
		[String] $Param3,
		[String] $ApiVersion = $global:ArmorConnection.ApiVersion
	)

	Begin
	{
		# The Begin section is used to perform one-time loads of data necessary to carry out the function's purpose
		# If a command needs to be run with each iteration or pipeline input, place it in the Process section

		# Check to ensure that a session to the Armor cluster exists and load the needed header data for authentication
		Test-ArmorConnection

		# API data references the name of the function
		# For convenience, that name is saved here to $function
		$function = $MyInvocation.MyCommand.Name

		# Retrieve all of the URI, method, body, query, result, filter, and success details for the API endpoint
		Write-Verbose -Message ( 'Gather API Data for {0}.' -f $function )
		$resources = ( Get-ArmorApiData -Endpoint $function ).$ApiVersion

		Write-Verbose -Message ( 'Load API data for {0}.' -f $resources.Function )
		Write-Verbose -Message ( 'Description: {0}.' -f $resources.Description )
	} # End of Begin

	Process
	{
		$uri = New-UriString -Server $Server -Endpoint $resources.Uri -id $id

		$uri = Test-QueryParam -QueryKeys $resources.Query.Keys -Parameters ( Get-Command -Name $function ).Parameters.Values -Uri $uri

		$body = New-BodyString -BodyKeys $resources.Body.Keys -Parameters ( Get-Command -Name $function ).Parameters.Values

		$result = Submit-Request -Uri $uri -Header $header -Method $resources.Method -Body $body

		$result = Test-ReturnFormat -ApiVersion $ApiVersion -Result $result -Location $resources.Result

		$result = Test-FilterObject -Filter $resources.Filter -Result $result

		Return $result
	} # End of Process
} # End of Function
