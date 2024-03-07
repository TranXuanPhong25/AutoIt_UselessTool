Sleep(100)
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
Sleep(200)

#Region ### START Koda GUI section ### Form=
Global $Form1_1 = GUICreate("untitled-notpad", 1002, 765, 620, 108, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP))
Global $MenuItem1 = GUICtrlCreateMenu("&File")
Global $MenuItem2 = GUICtrlCreateMenuItem("New"&@TAB&"CTRL+N", $MenuItem1)
Global $MenuItem3 = GUICtrlCreateMenuItem("Open"&@TAB&"CTRL+O", $MenuItem1)
Global $MenuItem4 = GUICtrlCreateMenuItem("Save"&@TAB&"CTRL+S", $MenuItem1)
Global $MenuItem5 = GUICtrlCreateMenuItem("", $MenuItem1)
Global $MenuItem6 = GUICtrlCreateMenuItem("Exit"&@TAB&"CTRL+SHIFT+X", $MenuItem1)
Global $MenuItem7 = GUICtrlCreateMenu("&Help")
Global $MenuItem8 = GUICtrlCreateMenuItem("About Notepad", $MenuItem7)
Global $Edit1 = GUICtrlCreateEdit("", 0, 0, 1000, 743)
GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 16, 400, 0, "Arial")
Global $Form1_1_AccelTable[2][2] = [["{CAPS LOCK}", $MenuItem2],["+,", $MenuItem8]]
GUISetAccelerators($Form1_1_AccelTable)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit


		Case $MenuItem2 ;new
;~ 			If GUICtrlRead($Edit1) Then
;~ 				MsgBox(0,"Notepad","s")
;~ 			EndIf
			savefile(true)

		Case $MenuItem3	;open
			local $filePath = FileOpenDialog("Open",@ScriptDir,'Text (*.txt)|All (*.*)',1,$form1_1)

			if $filePath Then
				local $selectedFile = FileOpen($filePath,128)
				local $data = FileRead($selectedFile)

				GUICtrlSetData($Edit1 ,$data)
				FileClose($selectedFile)
				updateTitle($filePath)


			EndIf


		Case $MenuItem4	;save

			local $filePath2 = savefile()
			updateTitle($filePath2)

		Case $MenuItem6 ;exit

			Exit

		Case $MenuItem8 ;about
			MsgBox(64+262144,'ABOUT',"THIS APP IS CODE BY ME")
		Case $Edit1
	EndSwitch
WEnd
func savefile($rqreset =false)

	local $content = GUICtrlRead($Edit1)
	if $content Then
		Local $filePath = FileSaveDialog("Save",@ScriptDir,'Text (*.txt)|All (*.*)',2+16,"",$Form1_1)
		if $filePath then
			FileWrite($filePath,$content)
			FileClose($filePath)
			if $rqreset Then
				GUICtrlSetData($Edit1,'')
			EndIf
		EndIf
	EndIf
	return $filePath
EndFunc

func updateTitle($filePath)
	Local $drive,$dir,$name,$ext
	local $arr= _PathSplit($filePath,$drive,$dir,$name,$ext)
	WinSetTitle($form1_1,'',$name&$ext & '- notepad')

EndFunc