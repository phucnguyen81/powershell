$pipe = new-object System.IO.Pipes.NamedPipeClientStream '.','testpipe','In'
$pipe.Connect()
$sr = new-object System.IO.StreamReader $pipe
while (($data = $sr.ReadLine()) -ne $null) { 
    "Received: $data" 
}
$sr.Dispose()
$pipe.Dispose()