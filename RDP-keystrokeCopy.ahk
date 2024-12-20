#Requires AutoHotkey v2.0


; Do manually the base64 encode
; $FileName = "C:\Windows\System32\cmd.exe"
; $base64string = [Convert]::ToBase64String([IO.File]::ReadAllBytes($FileName))
; [IO.File]::WriteAllBytes("$FileName.b64", [system.Text.Encoding]::UTF8.GetBytes($base64string))


FileToCopy := "C:\Users\Rom\Documents\unzipFileInMemory.ps1"
; TODO: Check that this file exists

; WinActivate "Untitled - Notepad"
; TODO: Check that this Windows exists in the current system
WinActivate "TRACS - Remote Desktop Connection"

; Open Notepad in the RDP window
; This does not work inside the RDP window:
; Run "notepad.exe"
; WinWait "Untitled - Notepad"
; MouseClick "Left"
Send "!{Home}"
Sleep 500
SendText "notepad++"
Sleep 3000
Send "{Enter}"
Sleep 4000

; Read the content from a local file
buf := FileRead(FileToCopy)
; Send the content in Notepad
SetKeyDelay 12,10
SendEvent "{Text}" buf


; Difficult to predict how long it will take, so do the rest manually for now.
;Sleep 10000
; Save the file on disk and close notepad
;Send "^s"

; Do manually the base64 decode
; $Base64FileName = "C:\Users\Rom\Documents\AutoHotkey\cmd.exe.b64"
; $decodedString = [Convert]::FromBase64String([System.Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($Base64FileName)))
; [IO.File]::WriteAllBytes("$FileName", $decodedString)
