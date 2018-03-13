<#
SCRIPT:     Download-FTPDirectory.ps1
DATE:       2018-03-13
AUTHOR:     Sam Dye

PURPOSE:
    Downloads an entire directory from an FTP site.

NOTES:

REV INFO:
    REV VER:   1.0
    MOD DATE:  N/A
    MOD AUTH:  N/A
#>

# copy Veeam Files
write-host "!!! Grabbing Veeam Files via FTP !!!"


# set FTP variables
$ftp = "ftp://ftp.site.com" 
$user = 'username' 
$pass = 'password'
$folder = 'Directory1'

# set local target
$target = "C:\bin\"

# end vars
$credentials = new-object System.Net.NetworkCredential($user, $pass)

function Get-FtpDir ($url,$credentials) {
    $request = [Net.WebRequest]::Create($url)
    $request.Method = [System.Net.WebRequestMethods+FTP]::ListDirectory
    if ($credentials) { $request.Credentials = $credentials }
    $response = $request.GetResponse()
    $reader = New-Object IO.StreamReader $response.GetResponseStream()
    while(-not $reader.EndOfStream) {
        $reader.ReadLine()
    }
    #$reader.ReadToEnd()
    $reader.Close()
    $response.Close()
}

# set folder path
$folderPath= $ftp + "/" + $folder + "/"

$files = Get-FTPDir -url $folderPath -credentials $credentials


$webclient = New-Object System.Net.WebClient 
$webclient.Credentials = New-Object System.Net.NetworkCredential($user,$pass) 
$counter = 0
foreach ($file in $files){
    $source=$folderPath + $file  
    #$destination = $target + $file
    $webclient.DownloadFile($source, $target+$file)

    # print file name and counter
    $counter++
    $counter
    $source
}
