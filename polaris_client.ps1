# Send requests to polaris server
param(
    [int]$Port = 8080
)

$baseUri = "http://localhost:${Port}"

$Response = Invoke-WebRequest "${baseUri}/helloworld"
$Response.Content

$Response = Invoke-WebRequest "${baseUri}/hellome?name=Phuc"
$Response.Content

$Response = Invoke-WebRequest "${baseUri}/hello" `
    -Method POST -Body (@{ Name = 'Phuc' } | ConvertTo-Json)
$Response.Content

$Response = Invoke-WebRequest "${baseUri}/invoke" `
    -Method POST -Body (@{ expr = 'Get-Date' } | ConvertTo-Json)
$Response.Content

# Invoke-WebRequest "${baseUri}/stop" -Method POST
