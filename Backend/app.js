var express = require('express');
var app = express();

var data = require('./data.js');

app.get('/times/:character', function(req, res){
  var character = req.params.character;

  if(!data[character])
  {
    res.send("error on char");
  } else {
    res.send(data[character]);
  }

});

app.get('/charactersAndTimes', function(req, res){
  res.send(data);
});

app.listen(3000, function () {
  console.log("running");
});
