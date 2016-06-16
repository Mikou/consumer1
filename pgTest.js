var pg = require('pg');
var conString = "postgres://uvis:uvis@localhost/refcard";


var query = "SELECT json_agg(json_build_object('id', id, 'name', name, 'activity', activity_project)) AS relation FROM person JOIN ( SELECT pid, json_agg(json_build_object('name', activity.name, 'project', p.name)) AS activity_project FROM activity JOIN ( SELECT project.code, json_build_object('name', project.name) AS name FROM project ) AS p ON p.code=activity.pcode GROUP BY pid ) AS activity ON activity.pid = person.id";


//this initializes a connection pool
//it will keep idle connections open for a (configurable) 30 seconds
//and set a limit of 10 (also configurable)
pg.connect(conString, function(err, client, done) {
  if(err) {
    return console.error('error fetching client from pool', err);
  }
  client.query("SELECT person.id, person.name, activity FROM person JOIN ( SELECT activity.pid, json_agg(json_build_object('name', activity.name, 'project', project.name)) AS activity FROM activity JOIN (SELECT code, json_build_object('name', project.name) AS name FROM project) AS project ON activity.pcode = project.code GROUP BY activity.pid) AS a ON a.pid = person.id", function(err, result) {
    //call `done()` to release the client back to the pool
    done();

    if(err) {
      return console.error('error running query', err);
    }
    console.log(result.rows);
    //output: 1
  });
});
