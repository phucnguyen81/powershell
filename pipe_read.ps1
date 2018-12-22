$pipe = new-object System.IO.Pipes.NamedPipeClientStream '.','testpipe','In'
$pipe.Connect()
$sr = new-object System.IO.StreamReader $pipe
while ($null -ne ($data = $sr.ReadLine())) { 
    Write-Output $data
}
$sr.Dispose()
$pipe.Dispose()