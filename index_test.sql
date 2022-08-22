USE TEST;
GO
CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
GO

-- read column average
SET STATISTICS TIME ON

	SELECT AVG(temperature) as AVG_TMP FROM Loading.baseball_json;

SET STATISTICS TIME OFF

-- read json average with cast
SET STATISTICS TIME ON

	SELECT AVG(CAST(JSON_VALUE(raw_json, '$.temperature') AS float)) as AVG_TMP_JSON FROM Loading.baseball_json;

SET STATISTICS TIME OFF

-- read json average with schema
SET STATISTICS TIME ON

	SELECT 
		AVG(j.temperature)
	FROM Loading.baseball_json bb
	CROSS APPLY OPENJSON(bb.raw_json)
	WITH(
	  temperature float
	  ) AS j;

SET STATISTICS TIME OFF