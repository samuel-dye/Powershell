<#
SCRIPT: Download-SpecificFilesFTP.ps1
DATE: 2017-12-18
AUTHOR: Sam Dye

PURPOSE:
    Downloads specific files from an FTP site, to specific locations on a local machine.

NOTES:

REV INFO:
    REV VER: 1.0
    MOD DATE: n/a
    MOD AUTH: n/a
#>

#ftp server info
$ftpPath1 = "ftp://ftp-page.ftp-site.com/directory1/file1"
$ftpPath2 = "ftp://ftp-page.ftp-site.com/directory1/file2"
$ftpPath3 = "ftp://ftp-page.ftp-site.com/directory2/file3"
$ftpUser = "username-for-ftp-site"
$ftpPass = "password-for-ftp-site"

#paths on local machine
$localPath1 = "C:\Users\username\bin\file1"
$localPath2 = "C:\bin\file2"
$localPath3 = "C:\Users\username\bin\directory1\file3"

$webclient = New-Object System.Net.WebClient 
$webclient.Credentials = New-Object System.Net.NetworkCredential($ftpUser,$ftpPass)  
$webclient.BaseAddress = $ftpPath

$webclient.DownloadFile($ftpPath1, $localPath1)
$webclient.DownloadFile($ftpPath2, $localPath2)
$webclient.DownloadFile($ftpPath3, $localPath3)