# fd -> pipe -> write
# start a process to run fd and write output to pipe
Start-Process -FilePath .\fd_pipe_write.ps1 -WindowStyle Hidden
# now read the pipe from that process
./pipe_read.ps1 | fzf