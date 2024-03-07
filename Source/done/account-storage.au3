#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
global const $CFP = @ScriptDir&"\info.ini"
#Region ### START Koda GUI section ### Form=C:\Users\Rengumin\Documents\Code\Source\template.kxf
Global $something = GUICreate("something", 573, 283, -1, -1)
GUISetFont(16, 400, 0, "Segoe UI")
Global $Label1 = GUICtrlCreateLabel("Username", 32, 16, 81, 34)
Global $Label2 = GUICtrlCreateLabel("Password", 32, 88, 91, 34)
Global $Admin = GUICtrlCreateInput("", 168, 16, 369, 38)
Global $password = GUICtrlCreateInput("", 168, 88, 369, 38, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
Global $Login = GUICtrlCreateButton("Login", 168, 184, 369, 49)
Global $Checkbox1 = GUICtrlCreateCheckbox("Remember", 168, 136, 329, 49)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

withdraw()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit




		Case $Login
			global $username =GUICtrlRead($Admin)
			global $pass=GUICtrlRead($password)

			if $username  and $pass Then
				MsgBox(0,"Notification","Login successfully")
				saveAcc($username,$pass)
			EndIf
			local $isRemember = GUICtrlRead($Checkbox1) == $GUI_CHecked
			if $isRemember Then
				IsRemember("true")
			Else
				IsRemember('false')
				FileDelete($CFP)
			EndIf
		Case $Checkbox1


	EndSwitch
WEnd
Func saveAcc($name,$pass)
	IniWrite($CFP,"Account","username",$name)
	IniWrite($CFP,"Account","password",$pass)
EndFunc
Func IsRemember($value)
	IniWrite($CFP,"option","Remember",$value)
EndFunc
Func withdraw()
	local $is = IniRead($CFP,"option","Remember",False)
	if $is ==true Then
		local $u =  IniRead($CFP,"Account","username","")
		local $p = IniRead($CFP,"Account","password","")
		GUICtrlSetState($Checkbox1,$GUI_CHECKED)
		GUICtrlSetData($Admin,$u)
		GUICtrlSetData($password,$p)
	EndIf
EndFunc
