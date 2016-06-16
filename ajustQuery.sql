/*SELECT '[1, 2, "foo", null]'::json;*/
 
/*SELECT json_build_object('age', person.age,'name', person.name,'id', person.id, 'activity', activity.fields) AS person FROM person JOIN (SELECT pid, json_agg(json_build_object('name', activity.name,'id', activity.id, 'project', project.fields)) AS fields FROM activity JOIN (SELECT code, json_build_object('name', project.name,'code', project.code) AS fields FROM project) AS project ON activity.pcode = project.code GROUP BY pid ) AS activity ON person.id = activity.pid;*/
 

SELECT json_build_object('type', 'agg', 'name', 'person', 'data', json_agg(json_build_object('age', person.age,'name', person.name,'id', person.id, 'activity', activity.fields))) AS data
FROM person JOIN (
  SELECT pid, json_build_object('type', 'agg', 'name', 'activity', 'data', json_agg(json_build_object('name', activity.name,'id', activity.id, 'project', project.fields))) AS fields 
  FROM activity JOIN (
    SELECT code, json_build_object('type', 'object', 'name', 'project', 'data', json_build_object('name', project.name, 'code', project.code)) AS fields 
    FROM project
  ) AS project ON activity.pcode = project.code GROUP BY pid 
) AS activity ON person.id = activity.pid;
