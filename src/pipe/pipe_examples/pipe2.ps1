$pipe = new-object System.IO.Pipes.NamedPipeClientStream("Solarwinds", 'Solarwinds', [System.IO.Pipes.PipeDirection]::InOut, [System.IO.Pipes.PipeOptions]::None, [System.Security.Principal.TokenImpersonationLevel]::Impersonation)
$pipe.Connect();  
$sw = new-object System.IO.StreamWriter($pipe);
$i = Get-Random -minimum 0 -maximum 100
$sw.WriteLine($i);
$sw.Flush();

$sw.WriteLine("exit"); 

$sw.Dispose(); 
$pipe.Close();