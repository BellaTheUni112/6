$listener.Start()
$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()
$writer = New-Object System.IO.StreamWriter($stream)
$reader = New-Object System.IO.StreamReader($stream)

while ($true) {
   $cmd = Read-Host "Command"
   if ($cmd -eq "exit") {
       $writer.WriteLine("exit")
       $writer.Flush()
       break
    }
    $writer.WriteLine($cmd)
    $writer.Flush()
    Start-Sleep -Milliseconds 500
   $response = $reader.ReadLine()
    Write-Host "Response: $response"
}

$client.Close()
$listener.Stop()
