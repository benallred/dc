# https://github.com/PowerShell/PSScriptAnalyzer
# https://github.com/PowerShell/PSScriptAnalyzer/blob/master/docs/Rules/README.md
@{
    Rules        = @{
        'PSAvoidUsingCmdletAliases' = @{
            'allowlist' = @('?', '%')
        }
    }
    ExcludeRules = @(
        'PSAvoidUsingWriteHost'
    )
}
