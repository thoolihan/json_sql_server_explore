USE TEST;
GO
CHECKPOINT;
GO
DBCC DROPCLEANBUFFERS;
GO

/* TO RUN AGAIN, RUN THESE QUERIES FIRST */
-- DROP INDEX Loading.baseball_json.idx_vResult;
-- ALTER TABLE Loading.baseball_json DROP COLUMN vRESULT;


-- filter results normal
SET STATISTICS TIME ON

	SELECT count(1)
	FROM Loading.baseball_json bb
	WHERE JSON_VALUE(bb.raw_json, '$.result') = 'strikeout';

SET STATISTICS TIME OFF

-- filter result with column added from json


ALTER TABLE Loading.baseball_json
	ADD vResult AS
	CAST(JSON_VALUE(raw_json, '$.result') as NVARCHAR(50));

SET STATISTICS TIME ON

	SELECT count(1)
	FROM Loading.baseball_json bb
	WHERE vResult = 'strikeout';

SET STATISTICS TIME OFF

-- filter results with index

CREATE INDEX idx_vResult ON [Loading].[baseball_json] (vResult);

SET STATISTICS TIME ON

	SELECT count(1)
	FROM Loading.baseball_json bb
	WHERE vResult = 'strikeout';

SET STATISTICS TIME OFF