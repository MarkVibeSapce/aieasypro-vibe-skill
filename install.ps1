# ติดตั้ง Vibe Coding skills เข้า ~/.claude/skills/ (Windows PowerShell)
$ErrorActionPreference = "Stop"

$Src  = Join-Path $PSScriptRoot "skills"
$Dest = Join-Path $HOME ".claude\skills"

Write-Host "Installing Vibe Coding skills"
Write-Host "   from: $Src"
Write-Host "   to:   $Dest"
Write-Host ""

New-Item -ItemType Directory -Force -Path $Dest | Out-Null

$count = 0
Get-ChildItem -Path $Src -Directory | ForEach-Object {
    $name = $_.Name
    $target = Join-Path $Dest $name
    if (Test-Path $target) {
        Write-Host "   update $name"
        Remove-Item -Recurse -Force $target
    } else {
        Write-Host "   install $name"
    }
    Copy-Item -Recurse -Path $_.FullName -Destination $target
    $count++
}

Write-Host ""
Write-Host "Done - installed $count skills"
Write-Host "   Restart Claude Code and type /help to see all skills"
