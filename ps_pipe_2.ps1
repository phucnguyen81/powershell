$pipe = new-object System.IO.Pipes.NamedPipeClientStream("POLLER_WHERE_SCRIPT_IS_RUNNING", 'Solarwinds', [System.IO.Pipes.PipeDirection]::InOut, [System.IO.Pipes.PipeOptions]::None, [System.Security.Principal.TokenImpersonationLevel]::Impersonation)
$pipe.Connect();  
$sw = new-object System.IO.StreamWriter($pipe);
$i = Get-Random -minimum 0 -maximum 100
$sw.WriteLine($i);
$sw.Flush();

$sw.WriteLine("exit"); 

$sw.Dispose(); 
$pipe.Close();