'use strict';

const express = require('express');

// Constants
const PORT = 3003;

// App
const app = express();

app.get('/files/:name', function(req, res, next) {
  var options = {
    root: __dirname + '/public/files',
    dotfiles: 'deny',
    headers: {
        'x-timestamp': Date.now(),
        'x-sent': true
    }
  };
  var filename = req.params.name;
  setTimeout(function () {
  res.sendFile(filename, options, function (err) {
    if (err) {
      console.log(err);
      res.status(err.status).end();
    }
    else {
      console.log('Sent:', filename);
    }
  })}, 3000);
});

app.use(express.static('public'));

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
