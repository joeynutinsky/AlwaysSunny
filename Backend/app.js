var express = require('express');
var app = express();

var data = require('./data.js'); //External data file

var port = 3000; //Port to listen on

//Get data for only a single character
//EX - /times/charlie
app.get('/times/:character', function(req, res){
  var character = req.params.character;

  if(!data[character]) //If that character doesn't exist
  {
    res.send("error on char");
  } else {
    res.send(data[character]);
  }

});

//Get data for ALL characters - used for initializing iOS app
app.get('/charactersAndTimes', function(req, res){
  res.send(data);
});

//Listener for incoming requests
app.listen(port, function () {
  console.log("running");
});
