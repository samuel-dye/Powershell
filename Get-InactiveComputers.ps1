import-module activedirectory
$domain = domain.com
$daysinactive = 90
$time = (Get-Date).Adddays(-($daysinactive))

get-adcomputer -filter {LastLogonTimeStamp -lt $time} -Properties LastLogonTimeStamp | select-object Name,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | export-csv c:\inactivecomputers.csv -notypeinformation
