$InputFileName = "C:\Users\Rom\Documents\newcer\orig\newcer.exe.b64.zip.b64"
$OutpuFileName = "C:\Users\Rom\Documents\newcer\newcer.exe.b64.zip"

$base64string = ""
$Base64FileName = "C:\Users\Rom\Documents\newcer\orig\newcer.exe.b64"
$base64string = [Convert]::FromBase64String([System.Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($InputFileName)))
[IO.File]::WriteAllBytes($OutpuFileName, [system.Text.Encoding]::UTF8.GetBytes($base64string))
Get-FileHash $OutpuFileName