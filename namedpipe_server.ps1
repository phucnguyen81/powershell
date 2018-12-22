$pipe = new-object System.IO.Pipes.NamedPipeServerStream 'testpipe','Out'
$pipe.WaitForConnection()
$sw = new-object System.IO.StreamWriter $pipe
$sw.AutoFlush = $true
$sw.WriteLine("Hello my client")
$sw.WriteLine("My server process id is $pid")
$sw.Dispose()
$pipe.Dispose()