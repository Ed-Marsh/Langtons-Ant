B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
'Ctrl + click to sync files: ide://run?file=%WINDIR%\System32\Robocopy.exe&args=..\..\Shared+Files&args=..\Files&FilesSync=True
#End Region

#Macro: Title, Export B4XPages, ide://run?File=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip

Sub Class_Globals
	Private Root As B4XView
	Private xui As XUI

	Private Button1 As B4XView
	Private cvs As B4XCanvas
	Private Pane1 As B4XView
	
	Dim Cont As Boolean
	
	Private CellSize As Int = 4
	
	Private Grid(500, 500) As Boolean  'True = black
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	
	cvs.Initialize(Pane1)
	
	cvs.DrawRect(cvs.TargetRect, xui.Color_White, True, 0)
	cvs.Invalidate

End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	Cont = False
End Sub

Private Sub Pane1_MouseClicked (EventData As MouseEvent)
	If EventData.SecondaryButtonPressed Then 
		Cont = True
		AntGo (EventData.X, EventData.Y)
	Else
		cvs.DrawCircle(EventData.x, EventData.y, 1, xui.Color_Black, True, 0)
		cvs.Invalidate
	End If
	
End Sub

Private Sub Pane1_MouseDragged (EventData As MouseEvent)
	cvs.DrawCircle(EventData.x, EventData.y, 1, xui.Color_Black, True, 0)
	cvs.Invalidate
End Sub

private Sub GetPixelFromCanvas(CanvasPane As Pane, X As Int, Y As Int) As Int
	' 1. Take a snapshot of the Pane/Canvas
	Dim bmp As B4XBitmap = CanvasPane.Snapshot
    
	' 2. Read the pixel using PixelReader
	Dim fxImage As JavaObject = bmp
	Dim pixelReader As JavaObject = fxImage.RunMethod("getPixelReader", Null)
    
	' Returns an ARGB integer directly
	Dim argbInt As Int = pixelReader.RunMethod("getArgb", Array As Object(X, Y))
	
	Return argbInt
	
End Sub

Private Sub AntGo (x As Double, y As Double)
	Dim gx As Int = x / CellSize
	Dim gy As Int = y / CellSize
	Dim Direction As Int = 1
	Dim MaxG As Int = Pane1.Width / CellSize

	Do While Cont = True
		'Read the centre of the cell
		Dim c As Int = GetPixelFromCanvas(Pane1, gx * CellSize + CellSize / 2, gy * CellSize + CellSize / 2)

		Dim isBlack As Boolean = Grid(gx, gy)
		If isBlack Then
			Direction = ((Direction + 2) Mod 4) + 1   'turn left
		Else
			Direction = (Direction Mod 4) + 1         'turn right
		End If
		Grid(gx, gy) = Not(isBlack)

		Dim r As B4XRect
		r.Initialize(gx * CellSize, gy * CellSize, gx * CellSize + CellSize, gy * CellSize + CellSize)
		If c = xui.Color_White Then
			cvs.DrawRect(r, xui.Color_Black, True, 0)
		Else
			cvs.DrawRect(r, xui.Color_White, True, 0)
		End If
		cvs.Invalidate

		Select Direction
			Case 1: gy = gy - 1
			Case 2: gx = gx + 1
			Case 3: gy = gy + 1
			Case 4: gx = gx - 1
		End Select
		
		If gx < 0 Or gy < 0 Or gx >= MaxG Or gy >= MaxG Then Cont = False
		
		Sleep(.1)
	Loop

End Sub


