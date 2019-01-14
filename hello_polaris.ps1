[cmdletbinding()]
param()

Import-Module -Name Polaris

New-PolarisGetRoute -Path '/helloworld' -Scriptblock {
    $Response.Send('Hello World!')
}

Start-Polaris -Port 8080

while($true) {
    Start-Sleep -Milliseconds 10
}
