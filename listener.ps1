$port = 4444
$listener = [System.Net.Sockets.TcpListener]::new([Net.IPAddress]::Any, $port)
$listener.Start()
Write-Host "Listening on port $port..."

$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()
$reader = New-Object System.IO.StreamReader($stream)
$writer = New-Object System.IO.StreamWriter($stream)
$writer.AutoFlush = $true

Write-Host "Client connected!"

while ($true) {
    $command = Read-Host "PS> "
    if ($command -eq "exit") { break }
    $writer.WriteLine($command)

    $output = ""
    while ($stream.DataAvailable) {
        $output += $reader.ReadLine() + "`n"
        Start-Sleep -Milliseconds 50
    }

    if ($output) {
        Write-Host $output
    }
}

Write-Host "Closing connection..."
$writer.Close()
$reader.Close()
$client.Close()
$listener.Stop()
