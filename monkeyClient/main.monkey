Strict
Import mojo
Import socket

Public
#MOJO_IMAGE_FILTERING_ENABLED = false
#MOJO_AUTO_SUSPEND_ENABLED = false

#TEXT_FILES+="*.txt|*.xml|*.json|*.imp|*.FMP|*.wld|*.glsl"
#IMAGE_FILES+="*.png|*.jpg"
#SOUND_FILES+="*.wav|*.ogg"

#MUSIC_FILES+="*.wav|*.ogg"
#BINARY_FILES+="*.bin|*.dat|*.fnt"

Function Main:Int()
	New Game()
	Return 0
End

Class Blob
	Field x:Int = 0
	Field y:Int = 0
	Field id:Int = 0
End

Class Game Extends App
	
	Global lastEvent:string
	
	Global blobs:List<Blob> = New List<Blob>()
	
	Field myBlob:Blob
	
	'summary:The OnCreate Method is called when mojo has been initialized and the application has been successfully created.
	Method OnCreate:Int()	
		'Set how many times per second the game should update and render itself
		SetUpdateRate(60)
		EventManager.RegisterEvents()
		OnEvent("", "") 'this is neccesary, because otherwise the monkey compire will remove the OnEvent function, because its not used (in monkey)
		myBlob = New Blob();
		'blobs.AddLast(myBlob)
		Return 0
	End
	
	'summary: This method is automatically called when the application's update timer ticks. 
	Method OnUpdate:Int()
		
		If (MouseHit(MOUSE_LEFT))
			myBlob.x = MouseX()
			myBlob.y = MouseY()
			EventManager.SendEvent("dot", MouseX() + "," + MouseY())
		EndIf
		 		
		Return 0
	End
	
	'summary: This method is automatically called when the application should render itself, such as when the application first starts, or following an OnUpdate call. 
	Method OnRender:Int()
		Cls()
		DrawText(lastEvent, 10, 10);

		SetColor(0, 255, 0)
		DrawRect(myBlob.x - 15, myBlob.y - 15, 30, 30)
		DrawText("you", myBlob.x - 15, myBlob.y - 10)
	
		For Local blob:Blob = EachIn blobs
			SetColor(255, 0, 0)
			DrawRect(blob.x - 15, blob.y - 15, 30, 30)
			SetColor(255, 255, 255)
			DrawText(blob.id, blob.x - 15, blob.y - 10);
		Next
		
		Return 0
	End

	'summary: This method is called instead of OnRender when the application should render itself, but there are still resources such as images or sounds in the process of being loaded. 
	Method OnLoading:Int()
		Return 0
	End
	
	'summary: This method is called when the application's device window size changes. 
	Method OnResize:Int()
		Return 0
	End
	
	'this function will be called from extern when socket.io recieves data
	Function OnEvent:Void(type:String, data:string)
		lastEvent = type + " - " + data;
		Print(type + " - " + data);
		Local split:String[] = data.Split(",");
		Select type
			Case "mov"	 'case of mov event  (blob moved (or created))
				For Local iblob:Blob = EachIn blobs
					If iblob.id = int(split[0])
						iblob.x = int(split[1])
						iblob.y = int(split[2])
						Return;
					EndIf
				Next
				'if no blob was found with id - create on
				Local blob:Blob = New Blob()
				blob.id = int(split[0])
				blob.x = int(split[1])
				blob.y = int(split[2])
				blobs.AddLast(blob)
			Case "del" 'case of del event, blob removed (user closed browser or smth)
				For Local iblob:Blob = EachIn blobs
					If iblob.id = int(split[0])
						blobs.Remove(iblob)
					EndIf
				Next
		End
	End
	
	'#REGION Code to handle susped status of the game goes here
	
	'summary: OnSuspend is called when your application is about to be suspended. 
	Method OnSuspend:Int()
	
		Return 0
	End
	
	'summary: OnResume is called when your application is made active again after having been in a suspended state. 
	Method OnResume:Int()
		
		Return 0
	End	
	'#END REGION
	
	'#REGION Code to handle game closing goes here:
	
	'summary: This method is called when the application's 'close' button is pressed. 
	Method OnClose:Int()
				
		Return Super.OnClose()
	End

	'summary:This method is called when the application's 'back' button is pressed. 
	Method OnBack:Int()

		Return Super.OnBack()
	End
	
	'#END REGION

End