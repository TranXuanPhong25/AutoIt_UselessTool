#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 Learn AutoIt - by JUNO_OKYO

 From J2TEAM with love!!!

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#RequireAdmin
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <Array.au3>

#Region ### START Koda GUI section ### Form=
Global $FormMain = GUICreate("Task Manager", 598, 420, -1, -1, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP))
Global $MenuItem1 = GUICtrlCreateMenu("File")
Global $MenuItem2 = GUICtrlCreateMenuItem("Refresh", $MenuItem1)
Global $MenuItem3 = GUICtrlCreateMenuItem("End process", $MenuItem1)
Global $MenuItem4 = GUICtrlCreateMenuItem("Exit", $MenuItem1)
GUISetFont(12, 400, 0, "Segoe UI")
Global $ListView1 = GUICtrlCreateListView("Name|PID", 0, 0, 614, 416)

_GUICtrlListView_SetColumnWidth($ListView1, 0, 200)
_GUICtrlListView_SetColumnWidth($ListView1, 1, 150)

GUICtrlSetResizing(-1, $GUI_DOCKAUTO)
	loadProcesses()


GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $MenuItem2 ; refresh
			update()
		Case $MenuItem3 ; Close process
			Local $index = _GUICtrlListView_GetSelectedIndices($ListView1)
			Local $name = _GUICtrlListView_GetItemText($ListView1, Number($index))
			ProcessClose($name)
			_GUICtrlListView_DeleteItemsSelected($ListView1)
;~ 			Local $sap = ProcessExists($name)
;~ 			local $PID = WinGetProcess($name)
;~ 			local $PID = ProcessGetStats($sap,0)
;~ 			MsgBox(0,'',$PID)
;~ 			_ArrayDisplay($PID)

;~ ProcessSetPriority(4780,5)
;~ local $arr = ProcessGetStats(Int($PID),$PROCESS_STATS_MEMORY )
;~  			_ArrayDisplay($arr)
;~ 			ProcessClose($processName)

		Case $MenuItem4 ; Exit
			Exit
	EndSwitch
WEnd

Func loadProcesses()
	Global $processes = ProcessList()
	GUICtrlCreateListViewItem("amount: "&$processes[0][0],$ListView1)
	For $i = 2 To $processes[0][0]
		; thêm dữ liệu với định dạng Name|PID
		GUICtrlCreateListViewItem($processes[$i][0] & '|' & $processes[$i][1], $ListView1)
	Next



EndFunc
func update()
	_GUICtrlListView_BeginUpdate($ListView1)
	_GUICtrlListView_DeleteAllItems($ListView1)
	loadProcesses()
	_GUICtrlListView_endUpdate($ListView1)
EndFunc

