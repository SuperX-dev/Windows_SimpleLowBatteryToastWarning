[reflection.assembly]::loadwithpartialname("System.Windows.Forms")
[reflection.assembly]::loadwithpartialname("System.Drawing")
$charge = (Get-WmiObject win32_battery).estimatedChargeRemaining
$notify = new-object system.windows.forms.notifyicon
$notify.icon = "Low_Battery.ico"
$notify.visible = $true
$notify.showballoontip(10,"Battery Low!","$charge% Remaining",[system.windows.forms.tooltipicon]::None)