<#
.SYNOPSIS
    Checks the health & status of the IMAP Proxy service, and starts it if not healthy and online.

.NOTES
    CREATE DATE:    2018-10-09
    CREATE AUTHOR:  Sam Dye
    REV NOTES:
            v1.0 - Completed script and deployed via Task Schedulder to run on startup, after a 15 minute delay.
       
#>

# add exchange management module
Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

# check status, and start if NOT already online
Get-HealthReport -Identity "$servername" | where {$_.HealthSet -eq "IMAP.Proxy"}
    if ({$_.State -ne "Online"}) {
            Set-ServerComponentState -Identity "$servername" -Component "imapproxy" -Requester "HealthAPI" -State "Active"
        }
        elseif ({$_.State -eq "Online"}) {
            exit
        }
