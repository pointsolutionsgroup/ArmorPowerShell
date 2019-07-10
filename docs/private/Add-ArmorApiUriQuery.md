---
external help file:
Module Name:
online version: https://tlindsay42.github.io/ArmorPowerShell/private/Add-ArmorApiUriQuery/
schema: 2.0.0
---

# Add-ArmorApiUriQuery

## SYNOPSIS
Builds the Armor API URI with one or more server-side filters.

## SYNTAX

```
Add-ArmorApiUriQuery [-Keys] <String[]> [-Parameters] <PSObject[]> [-Uri] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Builds a server-side filtering URL with a query string if there are any
parameter names or aliases specified in the calling cmdlet that match
the filter keys in the \`Query\` key.

## EXAMPLES

### EXAMPLE 1
```
$keys = ( $resources.Query | Get-Member -MemberType 'NoteProperty' ).Name; Add-ArmorApiUriQuery -Keys $keys; $parameters = ( Get-Command -Name $function ).Parameters.Values; Add-ArmorApiUriQuery -Keys $keys -Parameters $parameters -Uri 'https://api.armor.com/vms'
```

This is not a real example, but if valid, it would return the input URI with a
'Name' server-side filter (eg: https://api.armor.com/vms?name=TEST-VM)

## PARAMETERS

### -Keys
Specifies the query filters available to the endpoint.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Parameters
Specifies the parameters available within the calling cmdlet.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Uri
Specifies the endpoint's URI.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
###     You cannot pipe input to this cmdlet.
## OUTPUTS

### System.String
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/ArmorPowerShell/private/Add-ArmorApiUriQuery/](https://tlindsay42.github.io/ArmorPowerShell/private/Add-ArmorApiUriQuery/)

[https://github.com/tlindsay42/ArmorPowerShell/blob/master/Armor/Private/Add-ArmorApiUriQuery.ps1](https://github.com/tlindsay42/ArmorPowerShell/blob/master/Armor/Private/Add-ArmorApiUriQuery.ps1)

[https://docs.armor.com/display/KBSS/Armor+API+Guide](https://docs.armor.com/display/KBSS/Armor+API+Guide)

[https://developer.armor.com/](https://developer.armor.com/)

