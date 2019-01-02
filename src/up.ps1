# Go up to a directory matching a given text pattern.
param (
    $pattern = ''
)

# Given a path and a pattern, 
# finds the first ancestor directory that matchs the pattern
function findFirstDirMatch() {
    param (
        [string]$path = $(throw "missing directory path"),
        [string]$pattern = $(throw "missing text pattern for directory")
    )
    while (![string]::IsNullOrEmpty($path)) {
        $name = Split-Path $path -Leaf 
        if("$name".ToLower().Contains("$pattern".ToLower())) {
            return $path
        }
        else {
            $path = Split-Path $path
        }
    }
}

if ([string]::IsNullOrEmpty($pattern)) {
    Set-Location ..
}
else {
    $path = Get-Location
    $matchDir = (findFirstDirMatch "$path" "$pattern")
    if (![string]::IsNullOrEmpty($matchDir)) {
        Set-Location "$matchDir"
    }
}
