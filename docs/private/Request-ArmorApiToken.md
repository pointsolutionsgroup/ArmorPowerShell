---
external help file:
Module Name:
online version: https://tlindsay42.github.io/ArmorPowerShell/private/Request-ArmorApiToken/
schema: 2.0.0
---

# Request-ArmorApiToken

## SYNOPSIS
Retrieves an authentication token.

## SYNTAX

```
Request-ArmorApiToken [-Code] <String> [[-GrantType] <String>] [[-ApiVersion] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves an authentication token from a temporary authorization code.

## EXAMPLES

### EXAMPLE 1
```
Request-ArmorApiToken -Code '+8oaKtcO9kuVbjUXlfnlHCY3HmXXCidHjzOBGwr+iTo='
```

Submits the temporary authorization code to retrieve a new Armor API session
token.

## PARAMETERS

### -ApiVersion
Specifies the API version for this request.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: $Global:ArmorSession.ApiVersion
Accept pipeline input: False
Accept wildcard characters: False
```

### -Code
Specifies the temporary authorization code to redeem for a token.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -GrantType
Specifies the type of permission.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Authorization_code
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

### System.Management.Automation.PSObject
## NOTES
- Troy Lindsay
- Twitter: @troylindsay42
- GitHub: tlindsay42

## RELATED LINKS

[https://tlindsay42.github.io/ArmorPowerShell/private/Request-ArmorApiToken/](https://tlindsay42.github.io/ArmorPowerShell/private/Request-ArmorApiToken/)

[https://github.com/tlindsay42/ArmorPowerShell/blob/master/Armor/Private/Request-ArmorApiToken.ps1](https://github.com/tlindsay42/ArmorPowerShell/blob/master/Armor/Private/Request-ArmorApiToken.ps1)

[https://docs.armor.com/display/KBSS/Post+Token](https://docs.armor.com/display/KBSS/Post+Token)

[https://developer.armor.com/#!/Authentication/TenantOAuth_TokenAsync](https://developer.armor.com/#!/Authentication/TenantOAuth_TokenAsync)

