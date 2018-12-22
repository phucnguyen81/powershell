# write fd output to a named pipe
function Write-NamedPipeline {
  [cmdletbinding()]
  param(
    [parameter(
      Mandatory = $true,
      ValueFromPipeline = $true)]
    $pipelineInput
  )

  Begin {
    # open a named pipe and wait for client connection
    $pipe = new-object System.IO.Pipes.NamedPipeServerStream 'testpipe','Out'
    $pipe.WaitForConnection()

    # create a writer to write to the pipe
    $sw = new-object System.IO.StreamWriter $pipe
    $sw.AutoFlush = $true
  }

  Process {
    ForEach ($input in $pipelineInput) {
      $sw.WriteLine($input)
    }
  }

  End {
    $sw.Dispose()
    $pipe.Dispose()
  }

}

fd -I -d 3 | Write-NamedPipeline