'use strict';
const express = require('express');
const bodyParser = require('body-parser')
const mysql      = require('mysql');

const pg = require('pg');
const fs = require('fs');
const PORT = 3003;
const app = express();

app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())

app.get('/dataService/:id/:data', function (req, res, next) {
  if(req.params.data === 'schema') {
    var options = {};
    res.sendFile(__dirname + '/dataPackage/datapackage.json', options, function (err) {
      if (err) {
        console.log(err);
        res.status(err.status).end();
      }
    }, 500);
  } else {

    const conStr = 'postgres://uvis:uvis@localhost/refcard' + req.params.id;
    pg.connect(conStr, function (err, client, done) {
      if(err) {
        return console.error('error fetching client from pool', err);
      }
      var query = req.params.data;

      client.query(query, function (err, result) {
        done();
        if(err) {
          return console.error('error running query', err);
        }
        res.send(result.rows);
      });
    });
   
  }
});

app.post('/files/:name', function (req, res, next) {
  var body = '';
  var filePath = __dirname + '/public/files/' + req.params.name;

  req.on('data', function(data) {
    body += data;
  });

  req.on('end', function (){
    console.log(body);
    fs.writeFile(filePath, body, function() {
      //res.end();
      res.send(body);
    });
  });
});

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
  res.sendFile(filename, options, function (err) {
    if (err) {
      console.log(err);
      res.status(err.status).end();
    }
  });
});

function fetchData (query) {
  return new Promise( function (resolve, reject) {
    setTimeout(function () {
      resolve("DATA");
    }, 1000)
  });
}

app.get('/query/:query', function (req, res, next) {
  pg.connect(conStr, function (err, client, done) {
    if(err) {
      return console.error('error fetching client from pool', err);
    }
    var query = req.params.query;
    console.log(query);

    client.query(query, function (err, result) {
      done();
      if(err) {
        return console.error('error running query', err);
      }
      res.send(result.rows);
    });
  });
});

app.use('/:file', express.static('public'));
app.use(express.static('public'));

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
