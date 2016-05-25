Private
Import leben
Public
Import "extern.js"
#If CONFIG="debug"
#endif

Extern
Class EventManager = "EventManager"
	Function RegisterEvents:String()
	Function SendEvent:Void(type:String, data:String)
	'Function FakeEvent:Void(type:String, data:int[])
End Class
'
'Class Client = "Client"
'	Function getNick:String()
'	Function sendEvent:Void(type:String, data:string)
'	Function sendEvent:Void(type:String, data:int[])
'	
'	#If CONFIG="debug"
'	Function generateMap:Void()
'	#endif
'End Class
''
'Class PageData = "Client.pageData"
'	Global farm:int[][]
'	Global info:Int[]
'	Global task:Int[]
'	Global building:Int[]
'End