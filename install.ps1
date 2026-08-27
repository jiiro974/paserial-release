<#
  install.ps1 — bootstrap PASerial Windows (admin) : télécharge la dernière
  release depuis GitHub et installe (service, firewall, PATH, config).

  Usage (PowerShell admin) :
      irm https://raw.githubusercontent.com/jiiro974/paserial-release/main/install.ps1 | iex
  Désinstallation :
      .\install-windows.ps1 -Uninstall   (après extraction du zip)
#>
#requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

$Base = "https://github.com/jiiro974/paserial-release/releases/latest/download"
$Zip = Join-Path $env:TEMP "paserial-windows.zip"
$Dir = Join-Path $env:TEMP "paserial-setup"

Write-Host "Téléchargement de $Base/paserial-windows.zip ..."
Invoke-WebRequest -Uri "$Base/paserial-windows.zip" -OutFile $Zip

if (Test-Path $Dir) { Remove-Item -Recurse -Force $Dir }
Expand-Archive -Path $Zip -DestinationPath $Dir -Force

& "$Dir\install-windows.ps1"

Remove-Item $Zip -ErrorAction SilentlyContinue
Write-Host ""
Write-Host "Installation terminée. Démarrez : paserial serve --config C:\ProgramData\paserial\config.toml"
