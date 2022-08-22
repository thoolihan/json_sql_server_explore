USE TEST;

SELECT top 5 
    id
	,result
	,JSON_VALUE(raw_json, '$.temperature') as temperature_json
	,ISJSON(raw_json) as is_json
	,raw_json
FROM Loading.baseball_json;

SELECT 
	AVG(j.temperature)
FROM Loading.baseball_json bb
CROSS APPLY OPENJSON(bb.raw_json)
WITH(
  temperature float
  ) AS j


