$PipeSecurity = new-object System.IO.Pipes.PipeSecurity
$AccessRule = New-Object System.IO.Pipes.PipeAccessRule( "Everyone", "FullControl", "Allow" )
$PipeSecurity.AddAccessRule($AccessRule)
$pipeName = "Solarwinds"
$pipeDir  = [System.IO.Pipes.PipeDirection]::InOut
$pipeMsg  = [System.IO.Pipes.PipeTransmissionMode]::Message
$pipeOpti = [System.IO.Pipes.PipeOptions]::Asynchronous
#$pipe = New-Object system.IO.Pipes.NamedPipeServerStream( $pipeName, $pipeDir, 1, $pipeMsg, $pipeOpti, 32768, 32768, $PipeSecurity )

$pipe = New-Object system.IO.Pipes.NamedPipeServerStream( $pipeName, $pipeDir, 1, $pipeMsg, $pipeOpti, 32768, 32768, $PipeSecurity )
$pipe.WaitForConnection();
$sr = new-object System.IO.StreamReader($pipe); 
$cmd = " "
While ($cmd -ne $null)
{
	$cmd = $sr.Readline();
	If ($cmd -eq "exit")
	{
		$a = 2;
		break;
	}
	If ($cmd -ne $null) {Write-Host "Statistic.Powershell: " $cmd}
}
$sr.Dispose();
$pipe.Dispose();