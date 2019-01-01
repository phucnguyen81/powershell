# Copy spotlight lock screen images to wallpapers directory
# Source: https://www.laptopmag.com/articles/find-windows-10-lock-screen-pictures 

# Default location for spotlight lock screen image
$sourceDir="${env:USERPROFILE}/AppData/Local/Packages/Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy/LocalState/Assets"

$currentDir=(Get-Location)

$targetDir="${currentDir}/var/wallpapers"
If (-not (Test-Path "$targetDir")) {
  New-Item -Path "$targetDir" -ItemType "directory"
}

# Get the images
# Keep file long enough 
# Add jpg extension (auto-detection?)
# Skip images already exist in target directory
# Copy the images to target directory
Get-ChildItem "$sourceDir" `
  | Where-Object {$_.Length -ge 10000} `
  | Select-Object `
    @{Name="Source"; 
      Expression={"${sourceDir}/" + $_.Name}}, `
    @{Name="Target"; 
      Expression={"${targetDir}/" + $_.Name + ".jpg"}} `
  | Where-Object {-not (Test-Path $_.Target)} `
  | ForEach-Object {
      $source = $_.Source
      $target = $_.Target
      Copy-Item "$source" "$target"
  }
