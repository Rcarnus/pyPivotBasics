$InputFileName = "C:\Users\Rom\Documents\newcer\orig\newcer.exe.b64.zip"
$OutpuFileName = "C:\Users\Rom\Documents\newcer\orig\newcer.exe.b64.zip.b64"

$base64string = ""
$FileName = $InputFileName
$base64string = [Convert]::ToBase64String([IO.File]::ReadAllBytes($InputFileName))
[IO.File]::WriteAllBytes($OutpuFileName, [system.Text.Encoding]::UTF8.GetBytes($base64string))
Get-FileHash $OutpuFileName