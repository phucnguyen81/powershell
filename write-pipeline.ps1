# read process records from the pipeline and write them to host
function Write-PipeLineInfoValue {
[cmdletbinding()]
param(
    [parameter(
        Mandatory         = $true,
        ValueFromPipeline = $true)]
    $pipelineInput
)

    Begin {

        Write-Host `n"The begin {} block runs once at the start, and is good for setting up variables."
        Write-Host "-------------------------------------------------------------------------------"

    }

    Process {

        ForEach ($input in $pipelineInput) {

            Write-Host "Process [$($input.Name)] information"

            if ($input.Path) {
        
                Write-Host "Path: $($input.Path)"`n
        
            } else {

                Write-Host "No path found!"`n -ForegroundColor Red

            }

        }

    }

    End {

        Write-Host "-------------------------------------------------------------------------------"
        Write-Host "The end {} block runs once at the end, and is good for cleanup tasks."`n

    }

}

Get-Process | Select-Object -First 10 | Write-PipeLineInfoValue