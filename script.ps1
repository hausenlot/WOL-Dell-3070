$mac = "ADD REMOTE PC MAC ADDRESS"
$mac = $mac -replace ":", "-"
$target = [System.Net.IPAddress]::Broadcast
$client = New-Object System.Net.Sockets.UdpClient
$client.EnableBroadcast = $true
$client.Connect($target, 9)
$packet = [byte[]](@(0xFF) * 6 + ($mac.Split("-") | ForEach-Object { [Convert]::ToByte($_, 16) }) * 16)
$client.Send($packet, $packet.Length)
$client.Close()
