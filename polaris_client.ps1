# send requests to polaris server

$port = 8082
$baseUri = "http://localhost:${port}"

$Response = Invoke-WebRequest "${baseUri}/helloworld"
$Response.Content

$Response = Invoke-WebRequest "${baseUri}/hellome?name=Phuc"
$Response.Content

$Response = Invoke-WebRequest "${baseUri}/hello" `
    -Method POST -Body (@{ Name = 'Phuc' } | ConvertTo-Json)
$Response.Content

$Response = Invoke-WebRequest "${baseUri}/invoke" `
    -Method POST -Body (@{ Expr = 'Get-Date' } | ConvertTo-Json)
$Response.Content

