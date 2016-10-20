var express = require('express');
var app = express();

var data = require('./data.js');

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

app.listen(3000, function () {
  console.log("running");
});
