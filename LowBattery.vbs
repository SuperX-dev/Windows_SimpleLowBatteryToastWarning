set oLocator = CreateObject("WbemScripting.SWbemLocator")
set oServices = oLocator.ConnectServer(".","root\wmi")
set oResults = oServices.ExecQuery("select * from batteryfullchargedcapacity")
'change the path of your batch file
PathProgram = "execute.bat"
Set shell = CreateObject("WScript.Shell")
for each oResult in oResults
   iFull = oResult.FullChargedCapacity
next

while (1)
  set oResults = oServices.ExecQuery("select * from batterystatus")
  for each oResult in oResults
    iRemaining = oResult.RemainingCapacity
    bCharging = oResult.Charging
  next
  iPercent = ((iRemaining / iFull) * 100) mod 100
  if not bCharging and (iPercent < 20) Then Shell.Run chr(34) & "executeps1.bat" & Chr(34), 0
  wscript.sleep 300000
wend