USE TEST;
GO

SELECT top 5 
	id
	,result
	,CAST(JSON_VALUE(raw_json, '$.temperature') as float) as temperature_json
	,JSON_VALUE(raw_json, '$.result') as result_json
	,raw_json
FROM Loading.baseball_json;
GO

SELECT top 5 
	AVG(CAST(JSON_VALUE(raw_json, '$.temperature') AS float)) as temperature_json
FROM Loading.baseball_json;
GO

SELECT 
	AVG(j.temperature)
FROM Loading.baseball_json bb
CROSS APPLY OPENJSON(bb.raw_json)
WITH(
  temperature float
  ) AS j;
GO

