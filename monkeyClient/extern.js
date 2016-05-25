var test="irgendwas";

var EventManager = {}

EventManager.RegisterEvents = function(){
    //
    EventManager.io = io();
	
	EventManager.io.on('.', function (event) 
	{
		print ("event:" + event.type + " " + event.data);
		c_Game.m_OnEvent(event.type,event.data);
	});
	
    print("io on");
}

EventManager.SendEvent = function (type, data) {
	var event = {};
	event.type = type;
	event.data = data;
    EventManager.io.emit(".", event);
    print("io send");
}