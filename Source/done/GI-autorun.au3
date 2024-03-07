#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #include<Array.au3>
local $path = "C:\Program Files\Genshin Impact\Genshin Impact game\GenshinImpact.exe"
;~ global $path = "notepad"
;~ global $GI = ShellExecute($path)
;~ MsgBox(0,'',$GI)

;~ ProcessWait()

;~ ProcessGetStats
;~ ProcessSetPriority
;~ global $GI_PID = WinGetProcess($path)
;~ MsgBox(0,'',$GI_PID)
;~ ProcessExists
;~ ProcessClose($path)
;~ Exit
ShellExecute($path)
Local $hWnd = WinWait("[CLASS:UnityWndClass]", "", 10)
Local $iPID = WinGetProcess($hWnd)
ProcessSetPriority($iPID,5)
;~ Local $data = ProcessGetStats($iPID)
;~ if $data Then
;~ 	_ArrayDisplay($data)
;~ Else
;~ 	MsgBox(16+262144,'',"not found!")
;~ EndIf
;~ MsgBox(0,'',)
;~ _ArrayDisplay($data)

;~ Sleep(10000)
;~ ProcessClose($iPID)
Exit
