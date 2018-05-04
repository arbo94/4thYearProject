#Win1
$username = "Administrator"
$password = "3E)BrQ%E?xu*)UHeH9IYm(jODuhC7GB&"
$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$w1 = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

Invoke-Command -ComputerName  172.31.0.19 -Credential $w1 -Authentication Negotiate -ScriptBlock {aws s3 sync C:\Users\Administrator\Desktop\ s3://bucket-for-backups2/windows1/}  
exit



