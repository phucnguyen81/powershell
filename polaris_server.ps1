[cmdletbinding()]
param(
    [int]$Port = 8080
)

$Hey = "Hey, you!"
New-PolarisRoute -Path /helloworld -Method GET -Scriptblock {
    $Response.Send($Hey)
} -Force

New-PolarisRoute -Path /hellome -Method GET -Scriptblock {
    if ($Request.Query['name']) {
        $Response.Send('Hello ' + $Request.Query['name'])
    } else {
        $Response.Send('Hello World')
    }
}

$sbWow = {
    $json = @{
        wow = $true
    }
    # Json() helper function that sets content type
    $Response.Json(($json | ConvertTo-Json))
}

# Supports helper functions for Get, Post, Put, Delete
New-PolarisPostRoute -Path /wow -Scriptblock $sbWow

# Body Parameters are supported if server is run with -UseJsonBodyParserMiddleware
New-PolarisPostRoute -Path /hello -Scriptblock {
    if ($Request.Body.Name) {
        $Response.Send('Hello ' + $Request.Body.Name);
    } else {
        $Response.Send('Hello World');
    }
}

# Execute expressions
New-PolarisPostRoute -Path /invoke -Scriptblock {
    if ($Request.Body.expr) {
        $Expr = $Request.Body.expr
        $ResponseJson = Invoke-Expression $Expr | ConvertTo-Json
        $Response.Send($ResponseJson);
    } else {
        $Response.Send('Missing Request.Body.Expr');
    }
}

New-PolarisPostRoute -Path /stop -Scriptblock {
    Stop-Polaris
}

# Pass in script file
# New-PolarisRoute -Path /example -Method GET -ScriptPath .\script.ps1

# Also support static serving of a directory
New-PolarisStaticRoute -FolderPath ./static -RoutePath /public -EnableDirectoryBrowser $True

# Start the server, all params are optional
$App = Start-Polaris -Port $Port -MinRunspaces 1 -MaxRunspaces 5 -UseJsonBodyParserMiddleware -Verbose

while($App.Listener.IsListening) {
    Wait-Event callbackcomplete
}

# Stop the server
#Stop-Polaris
