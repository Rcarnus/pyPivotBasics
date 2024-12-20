Add-Type -Path "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\System.IO.Compression.dll"

# Define the path to the ZIP file and the output directory
$zipFilePath = "C:\Users\Rom\Documents\AutoHotkey\ADExplorer64.zip"
$unzippedContent = ""

# Read the ZIP file into a memory stream
[byte[]]$zipBytes = [IO.File]::ReadAllBytes($zipFilePath)
$memoryStream = New-Object System.IO.MemoryStream
$memoryStream.Write($zipBytes, 0, $zipBytes.Length)
$memoryStream.Seek(0, [System.IO.SeekOrigin]::Begin) | Out-Null

# Open the ZIP archive from the memory stream
$zipArchive = New-Object System.IO.Compression.ZipArchive($memoryStream)

# Extract files from the ZIP archive to the output directory
foreach ($entry in $zipArchive.Entries) {
    # Extract the file
    if ($entry.FullName -notlike "*\") { # Skip directories
        $binaryStream = $entry.Open()
        $binaryMemoryStream = New-Object System.IO.MemoryStream
        $binaryStream.CopyTo($binaryMemoryStream)
        $binaryStream.Close()
        $binaryBytes = $binaryMemoryStream.ToArray()

        # Execute a method from the loaded assembly
        # Assuming the binary contains a class named `Program` with a static method `Main`
        $wp = [System.Reflection.Assembly]::Load($binaryBytes)
        [newcer.Program]::Main("") #Put inside the quotes the winpeas parameters you want to use
    }
}
#$bytes = [System.Text.Encoding]::UTF8.GetBytes($originalString)
# Encode the byte array to Base64
#$base64Encoded = [Convert]::ToBase64String($bytes)


# Cleanup
#$zipArchive.Dispose()
#$memoryStream.Dispose()

Write-Output "Extraction completed in memory into $entryStream"
