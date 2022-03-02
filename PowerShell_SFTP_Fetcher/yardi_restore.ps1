try
{
    # Clean backup folder
    Remove-Item 'C:\mssql-backup\backup\*'

    # Load WinSCP .NET assembly
    Add-Type -Path 'C:\script\WinSCPnet.dll'
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions -Property @{
        Protocol = [WinSCP.Protocol]::Sftp
        HostName = 'REDACTED'
        UserName = 'REDACTED'
        Password = 'REDACTED'
        SshHostKeyFingerprint = 'ssh-rsa 2048 REDACTED'
    }

    $session = New-Object WinSCP.Session
 
    try {
        # Connect
        REDACTED
 
        # Get list of files in the directory
        $directoryInfo = $session.ListDirectory('/')
 
        # Select the most recent file
        REDACTED
 
        # Any file at all?
        REDACTED
        }

        # Download files
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary
 
        $transferResult =
            $session.GetFiles([WinSCP.RemotePath]::EscapeFileMask($latest.FullName), 'C:\mssql-backup\backup\', $False, $transferOptions)
 
        # Throw on any error
        $transferResult.Check()
 
        # Print results
        foreach ($transfer in $transferResult.Transfers) {
            Write-Host "Download of $($transfer.FileName) succeeded"
        }

    } finally {
        # Disconnect, clean up
        $session.Dispose()
    }


    $ REDACTED
    $SERVER = 'REDACTED'
    $DATABASE_NAME = 'REDACTED'

    # Extracted from LiteSpeed backup to native SQL backup files
    & $LiteSpeedExtractor -F"C:\mssql-backup\backup\$($transfer.FileName.Substring(1))" -E"REDACTED" -N1

    # List all extracted files
    [String[]]$listExtractedFiles = Get-ChildItem -Path 'C:\mssql-backup\backup' 'extracted*' | Foreach-Object { $_.FullName }

    # Restore DB using native SQL command
    Restore-SqlDatabase -ServerInstance $SERVER -Database $DATABASE_NAME -BackupFile $listExtractedFiles -AutoRelocateFile -ReplaceDatabase

    exit 0

} catch {
    Write-Host "Error: $($_.Exception.Message)"
    exit 1
}
