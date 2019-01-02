# Go up to ancestor directories either by levels or by text pattern.
param (
    [string]$ups = ''
)

function findFirstDirMatch() {
    param (
        [string]$path = $(throw "missing directory path"),
        [string]$pattern = $(throw "missing text pattern for directory")
    )
    while (![string]::IsNullOrEmpty($path)) {
        $name = Split-Path $path -Leaf 
        if ("$name".ToLower().Contains("$pattern".ToLower())) {
            return $path
        }
        else {
            $path = Split-Path $path
        }
    }
}

$ErrorActionPreference = "Stop" # fail on first error

if ($ups -match "^[\d\.]+$") {
    $levels = [int]$ups
    for ($i = 0; $i -lt $levels; $i++) {
        Set-Location '..'
    }
}
else {
    $pattern = "$ups"
    if ([string]::IsNullOrEmpty($pattern)) {
        Set-Location ..
    }
    else {
        $currentLoc = Get-Location
        $matchDir = (findFirstDirMatch "$currentLoc" "$pattern")
        if (![string]::IsNullOrEmpty($matchDir)) {
            Set-Location "$matchDir"
        }
    }
}

Get-ChildItem | more
