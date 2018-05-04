#Win2

$username2 = "Administrator"
$password2 = "3E)BrQ%E?xu*)UHeH9IYm(jODuhC7GB&"
$secstr2 = New-Object -TypeName System.Security.SecureString
$password2.ToCharArray() | ForEach-Object {$secstr2.AppendChar($_)}
$w2 = new-object -typename System.Management.Automation.PSCredential -argumentlist $username2, $secstr2

Invoke-Command -ComputerName  172.31.0.20 -Credential $w2 -Authentication Negotiate -ScriptBlock {aws s3 sync C:\Users\Administrator\Desktop\ s3://bucket-for-backups2/windows2/}  
exit

