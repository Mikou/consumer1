/*http://stackoverflow.com/questions/21137237/postgres-nested-json-array-using-row-to-json*/

/* original SQL string */
/*SELECT Activity.PID, Project.code, Activity.ActivityName, Activity.Start_date FROM ( ( (SELECT Person.ID FROM [Person] ) AS parent1 ) LEFT join [Activity] on parent1.ID = Activity.PID ) LEFT join [Project] on Activity.PCode = Project.Code WHERE [Start_date]  > #1-1-2012# ;*/

SELECT row_to_json(t)
FROM (
  SELECT name,
    (
      SELECT array_to_json(array_agg(row_to_json(a))) FROM (
        SELECT name FROM activity WHERE activity.pcode=project.code
      ) a
    ) AS activities
  FROM project
) AS t;

/*SELECT pid, json_agg(json_build_object('code', p.code, 'name', p.name)) AS agg
FROM activity JOIN (
  SELECT project.code, project.name FROM project
) AS p ON p.code=activity.pcode
GROUP BY pid;
*/

SELECT json_build_object('age', person.age,'name', person.name,'id', person.id, 'activity', activity.fields) AS fields 
FROM person JOIN (
  SELECT pid, json_agg(json_build_object('name', activity.name,'id', activity.id)) AS fields 
  FROM activity
  GROUP BY pid
) AS activity ON person.id = activity.pid;

/*SELECT json_build_object(
  'age', person.age,
  'name', person.name,
  'id', person.id, 
  'activity', activity.fields) AS fields 
FROM person JOIN (
  SELECT pid, json_build_object(
    'name', activity.name,
    'id', activity.id, 
    'project', project.fields) AS fields 
  FROM activity JOIN (
    SELECT code, json_build_object(
      'name', project.name,
      'code', project.code) AS fields 
    FROM project
  ) AS project ON activity.pcode = project.code 
  GROUP BY pid 
) AS activity ON person.id = activity.pid*/


/*SELECT json_build_object('age', person.age,'name', person.name,'id', person.id, 'activity', activity.fields) AS fields 
FROM person JOIN (
  SELECT pid, json_build_object('name', activity.name,'id', activity.id, 'project', project.fields) AS fields 
  FROM activity JOIN (
    SELECT code, json_build_object('name', project.name,'code', project.code) AS fields 
    FROM project
  ) AS project ON activity.pcode = project.code
) AS activity ON person.id = activity.pid*/



/* WHAT SHOULD BE BUILT*/
SELECT json_build_object('age', person.age,'name', person.name,'id', person.id, 'activity', activity.fields) 
FROM person JOIN (
  SELECT pid, json_agg(json_build_object('name', activity.name,'id', activity.id, 'project', project.fields)) AS fields
  FROM activity JOIN (
    SELECT code, json_build_object('name', project.name,'code', project.code) AS fields
    FROM project
  ) AS project ON activity.pcode = project.code 
  GROUP BY pid
) AS activity ON person.id = activity.pid;


/*SELECT json_agg(json_build_object('id', id, 'name', name, 'activity', agg)) FROM person JOIN (
  SELECT pid, json_agg(json_build_object('name', activity.name, 'code', p.code)) AS agg
  FROM activity JOIN (
    SELECT project.code, project.name FROM project
  ) AS p ON p.code=activity.pcode
  GROUP BY pid
) AS activity ON activity.pid = person.id;*/


/* REFERENCE QUERY */
SELECT json_agg(json_build_object('id', id, 'name', name, 'activity', activity_project)) AS relation FROM person JOIN (
  SELECT pid, json_agg(json_build_object('name', activity.name, 'project', p.name)) AS activity_project
  FROM activity JOIN (
    SELECT project.code, json_build_object('name', project.name) AS name FROM project
  ) AS p ON p.code=activity.pcode
  GROUP BY pid
) AS activity ON activity.pid = person.id;



SELECT project.code, json_build_object('name', project.name) AS name FROM project


/*SELECT pid, json_agg(json_build_object('code', code, 'name', name)) AS agg
FROM activity JOIN (
  SELECT code FROM project
) AS p ON p.code=activity.pcode
GROUP BY pid;*/

