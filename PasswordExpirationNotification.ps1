#2018-10-02
#This utility notifies user to change the password if it hasn't been changed in the past X days
#Command to run this utility
#powershell -windowstyle hidden -file PasswordExpirationNotification.ps1

#Pull the current AD user's properties
$Searcher = [adsisearcher]::new()
$Searcher.Filter="SamAccountName=$($env:USERNAME)"
$User = $Searcher.FindOne().Properties

#Find how long it has been since the password was changed
$daysUnchanged=((Get-Date) - [datetime]::fromfiletime($User.pwdlastset[0])).Days

#If password hasn't been changed for X days, notify the user to change the password. In this script, it is set to 160 days 
if ($daysUnchanged -gt 160){ 
    Add-Type -AssemblyName 'System.Windows.Forms'
    [System.Windows.Forms.MessageBox]::Show("Your password was set $daysUnchanged ago and will expire soon, press Ctrl+Alt+Del to change it.")
}