#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\Downloads\17902_power_shutdown_icon.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <DateTimeConstants.au3>
#include<Date.au3>
#Region ### START Koda GUI section ### Form=C:\Users\Rengumin\Documents\Code\Source\Form1_1.kxf
Global $Form1_1 = GUICreate("Scheduler", 598, 583, -1, -1)
Global $Option_Label = GUICtrlCreateLabel("Choose Option", 16, 32, 143, 34)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $dropbox = GUICtrlCreateCombo("", 304, 32, 281, 25, BitOR($GUI_SS_DEFAULT_COMBO,$CBS_SIMPLE))
GUICtrlSetData(-1, "Shut Down|Restart","Shut Down")
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $force = GUICtrlCreateCheckbox("Terminate all application", 16, 94, 249, 34, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_LEFT))
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $timeout = GUICtrlCreateCheckbox("Set Time-out", 16, 156, 153, 34, BitOR($GUI_SS_DEFAULT_CHECKBOX,$BS_LEFT))
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $timeout_label = GUICtrlCreateLabel("Time-out", 16, 218, 88, 34)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $stime = GUICtrlCreateInput("",120, 216, 137, 38, BitOR($GUI_SS_DEFAULT_INPUT,$ES_CENTER,$ES_NUMBER))
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $comment = GUICtrlCreateLabel("Comment", 16, 280, 95, 34)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $timepicker = GUICtrlCreateButton("Time Picker", 392, 216, 185, 41)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, 0x6D6D6D)
Global $comment_content = GUICtrlCreateInput("", 17, 328, 561, 131)
GUICtrlSetFont(-1, 14, 400, 0, "Arial")
Global $scond = GUICtrlCreateLabel("seconds", 270, 222, 79, 34)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
Global $Start = GUICtrlCreateButton("Start", 70, 492, 185, 49, $WS_BORDER)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
GUICtrlSetBkColor(-1, 0xC0DCC0)
Global $Abort = GUICtrlCreateButton("Abort", 334, 493, 185, 49, $WS_BORDER)
GUICtrlSetFont(-1, 16, 400, 0, "Segoe UI")
GUICtrlSetBkColor(-1, 0xFF0000)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


#Region ### START Koda GUI section ### Form=
Global $Time_Picker = GUICreate("Time_Picker", 242, 163, -1, -1, -1, -1, $Form1_1)
GUISetFont(14, 400, 0, "Segoe UI")
Global $Date1 = GUICtrlCreateDate(@TAB&"", 16, 16, 209, 49, BitOR($DTS_UPDOWN,$DTS_TIMEFORMAT))
Global $Button1 = GUICtrlCreateButton("OK", 16, 88, 209, 49,'',$BS_DEFPUSHBUTTON)
GUISetState(@SW_HIDE)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[0]
		Case $GUI_EVENT_CLOSE
			If $nMsg[1]==$Form1_1 Then
				Exit
			Else
				GUISetState(@SW_HIDE,$Time_Picker)
			EndIf

		Case $dropbox
			local $option = GUICtrlRead($dropbox)

		Case $force

		Case $timeout
			if GUICtrlRead($timeout) =$GUI_CHECKED then
				toggleTimer(true)
			Else
				toggleTimer(false)
			endif
		Case $Start
;~ 			MsgBox(0,0,excutor())
			Run(excutor(),'',@SW_HIDE)
		Case $Abort

			Run('shutdown -a','',@SW_HIDE)
		Case $timepicker
			GUISetState(@SW_SHOW,$Time_Picker)
		Case $Button1
			local $timer = _NowCalcDate() & " " & GUICtrlRead($Date1)
			local $countdown = _datediff("s",$timer,_NowCalc())
			$countdown = -($countdown - 43200)

			if $countdown <= 0 Then
				MsgBox(16 +262144,'Error' ,"please enter an valid period")
			Else
				GUICtrlSetData($stime,$countdown)
			EndIf
			GUISetState(@SW_HIDE,$Time_Picker)

	EndSwitch
WEnd
func toggleTimer($enable)
	local $value = $enable ? $GUI_ENABLE : $GUI_DISABLE

	GUICtrlSetState($timeout_label,$value)
	GUICtrlSetState($scond,$value)
	GUICtrlSetState($stime,$value)
	GUICtrlSetState($timepicker,$value)
EndFunc
func excutor()
;~ 	set default time
	if not GUICtrlRead($stime) Then
		GUICtrlSetData($stime,30)
	EndIf
;~ 	add something
	local $exc = "shutdown "
	$exc &= GUICtrlRead($dropbox) == "Shut Down"?"-s":"-r"
	$exc &= GUICtrlRead($force)==$GUI_CHECKED?' -f':''
	$exc &= GUICtrlRead($timeout)==$GUI_CHECKED and GUICtrlRead($stime)? ' -t '&GUICtrlRead($stime):''
;~ 	commment
	$exc = GUICtrlRead($comment_content)?$exc  &' -c ' &'"'& GUICtrlRead($comment_content) &'"': $exc
	Return $exc
EndFunc