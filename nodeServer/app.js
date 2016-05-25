console.log('Hello world');

var express = require('express');
var app = express();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var lastConnectionID = 0;

app.use(express.static('client'));

app.get('/', function (req, res)
{
	res.sendFile('MonkeyGame.html', { root: __dirname + '/client'});
});

io.on('connection', function (socket)
{
	lastConnectionID++;
	io.emit('connected, ID: ' + lastConnectionID);
	socket.connID = lastConnectionID;

	socket.on('disconnect', function ()
	{
		var event = {};
		event.type = "del"; //type to delete a player
		event.data = "" + socket.connID; //the conn id (must be a string, because monkeyside only get string (no dynamic typing there)
		socket.broadcast.emit('.', event);//send this event to all clients (but not itself)
		

		console.log('disconnect: ' + socket.connID);
	});

	socket.on('.', function (event)
	{
		event.type = "mov";
		event.data = "" + socket.connID + "," + event.data;
		socket.broadcast.emit('.', event);//send this event to all clients (but not itself)

		console.log(event.type + ' ' + event.data);
	});
});

http.listen(3000, function ()
{
	console.log('listening on *:3000');
});