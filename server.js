'use strict';
const express = require('express');
const bodyParser = require('body-parser')
const mysql      = require('mysql');

const pg = require('pg');
const conStr = 'postgres://uvis:uvis@localhost/refcard';

var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'uvis',
  password : 'uvis',
  database : 'refCard'
});

// Constants
const PORT = 3003;

// App
const app = express();
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())


app.get('/dataPackage/:path', function (req, res, next) {

  var options = {};

  res.sendFile(__dirname + '/dataPackage/' + req.params.path, options, function (err) {
    if (err) {
      console.log(err);
      res.status(err.status).end();
    }
  }, 500);


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
  setTimeout(function () {
  res.sendFile(filename, options, function (err) {
    if (err) {
      console.log(err);
      res.status(err.status).end();
    }
  })}, 500);
});


function fetchData (query) {

  return new Promise( function (resolve, reject) {

    setTimeout(function () {
      resolve("DATA");
    }, 1000)

  });
}


//SELECT pid, code FROM person JOIN (SELECT pid, code FROM activity JOIN (SELECT code FROM project) AS project ON activity.pcode = project.code) AS activity ON person.id = activity.pid;

function buildQuery(query) {


  console.log(query);
  let str = "";
  let select = "SELECT ";  

  for(let i=0, len = query.properties.length; i<len; i++) {
    const property = query.properties[i];

    select += property.name;
    if(i<len-1) {
      select += ",";
    }

  }

  const from = "FROM " + query.name;

  if(query.expand) {
    return buildQuery(query.expand);
  }

  return str;

}

app.get('/query/:query', function (req, res, next) {

  console.log('RECEIVED QUERY:', req.params.query);

  pg.connect(conStr, function (err, client, done) {

    if(err) {
      return console.error('error fetching client from pool', err);
    }

    client.query(req.params.query, function (err, result) {

      done();

      if(err) {
        return console.error('error running query', err);
      }

      res.send(result.rows);

    });

  });

  /*connection.connect();

  var options = {sql: req.params.query, nestTables: true};

  console.log(req.params.query);

  connection.query(req.params.query, function (err, rows, fields) {
    if (err) throw err;

    console.log(rows);
    console.log(fields);

  });

  connection.end();*/

});

app.use(express.static('public'));

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);
