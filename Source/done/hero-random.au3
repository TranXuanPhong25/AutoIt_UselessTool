#include <ButtonConstants.au3>
#include "Json.au3"
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include<Array.au3>
;~ MsgBox(0,0,graphAPI("https://lienminh.garena.vn/champions","GET"))
global $html = graphAPI("https://lienminh.garena.vn/champions","GET")
Global $pure_heroes = StringRegExp($html, "class=""name"" data-v-5eb1082c>\w+.?\w+",3)
global $heroes=[]
global $img =[]
For $hero in  $pure_heroes
	local $x = StringRegExp($hero,">.+",1)



	$x= _ArrayToString($x)
	$x = StringTrimLeft($x,1)
	if $x="ng" then
		$x="Wukong"
	EndIf
	if $x="Dr" then
		$x="Dr.Mundo"
	EndIf
	_ArrayAdd($heroes,$x)

	_ArrayAdd($img,"https://cdngarenanow-a.akamaihd.net/games/lol/2020/LOLwebsite/champion/"&$x&"_0.jpg")
Next
_ArrayDelete($heroes,"0")
_ArrayDelete($img,"0")
_ArrayDisplay($heroes)
func graphAPI($path,$method)
	global $ohttp = ObjCreate("WinHttp.WinHttpRequest.5.1")
	$ohttp.open($method,$path,false)
	$ohttp.send()
	$ohttp.WaitForResponse()
	return $ohttp.responseText()
EndFunc