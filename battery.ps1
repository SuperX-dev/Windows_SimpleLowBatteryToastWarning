[reflection.assembly]::loadwithpartialname("System.Windows.Forms")
[reflection.assembly]::loadwithpartialname("System.Drawing")
$ErrorActionPreference = "Stop"
$charge = (Get-WmiObject win32_battery).estimatedChargeRemaining
$notificationTitle = "Battery Low! | "+ $charge + "% Remaining"
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastImageAndText01)
$toastXml = [xml] $template.GetXml()
$toastXml.GetElementsByTagName("text").AppendChild($toastXml.CreateTextNode($notificationTitle)) > $null
$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
$xml.LoadXml($toastXml.OuterXml)
$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
$toast.Tag = "Test1"
$toast.Group = "Test2"
$toast.ExpirationTime = [DateTimeOffset]::Now.AddSeconds(5)
$notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Battery Status")
$notifier.Show($toast);