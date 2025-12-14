<#
Simple build script for Quiz_preFinal
Usage (PowerShell):
  ./build.ps1

This will create a `dist/` folder containing the production files
and produce `Quiz_preFinal.zip` in the project root.
#>
Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Definition
Push-Location $here

Write-Host "Cleaning previous build..."
if (Test-Path .\dist) { Remove-Item .\dist -Recurse -Force }
if (Test-Path .\Quiz_preFinal.zip) { Remove-Item .\Quiz_preFinal.zip -Force }

Write-Host "Creating dist/ and copying files..."
New-Item -ItemType Directory -Path .\dist | Out-Null

# Copy root html files
Copy-Item -Path .\index.html -Destination .\dist\ -Force
Copy-Item -Path .\start.html -Destination .\dist\ -Force

# Copy static folders
Copy-Item -Path .\media -Destination .\dist\ -Recurse -Force
Copy-Item -Path .\basic-human-model.glb -Destination .\dist\ -Recurse -Force

# Copy README
Copy-Item -Path .\README.md -Destination .\dist\ -Force

Set-Location .\dist

Write-Host "Creating zip archive Quiz_preFinal.zip..."
Compress-Archive -Path * -DestinationPath ..\Quiz_preFinal.zip -Force

Pop-Location

Write-Host "Build complete. Created 'dist/' and 'Quiz_preFinal.zip'."
