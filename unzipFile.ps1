Add-Type -Path "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.IO.Compression.dll"

# Define the path to the ZIP file and the output directory
$zipFilePath = "C:\Users\Rom\Documents\AutoHotkey\ADExplorer64.zip"
$outputDirectory = "C:\Users\Rom\Documents\AutoHotkey\ADExplorer64.exe"

# Read the ZIP file into a memory stream
[byte[]]$zipBytes = [IO.File]::ReadAllBytes($zipFilePath)
$memoryStream = New-Object System.IO.MemoryStream
$memoryStream.Write($zipBytes, 0, $zipBytes.Length)
$memoryStream.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null

# Open the ZIP archive from the memory stream
$zipArchive = New-Object System.IO.Compression.ZipArchive($memoryStream)

# Extract files from the ZIP archive to the output directory
foreach ($entry in $zipArchive.Entries) {
    $destinationPath = Join-Path $outputDirectory $entry.FullName

    # Ensure the directory exists
    $directoryPath = Split-Path $destinationPath
    if (!(Test-Path -Path $directoryPath)) {
        New-Item -ItemType Directory -Path $directoryPath | Out-Null
    }

    # Extract the file
    if ($entry.FullName -notlike "*\") { # Skip directories
        $entryStream = $entry.Open()
        $fileStream = [System.IO.File]::Create($destinationPath)
        $entryStream.CopyTo($fileStream)
        $entryStream.Close()
        $fileStream.Close()
    }
}

# Cleanup
$zipArchive.Dispose()
$memoryStream.Dispose()

Write-Output "Extraction completed successfully to $outputDirectory"
