USE TEST;
GO

DROP TABLE LOADING.baseball_json;
GO

create table Loading.baseball_json (
    id bigint primary key identity,
	result nvarchar(50),
	temperature float CHECK (temperature > -20 and temperature < 140),
    raw_json nvarchar(max) CHECK (ISJSON(raw_json)=1),
);
GO

/*
alter table Loading.baseball_json
	ADD CONSTRAINT chk_json CHECK(ISJSON(raw_json)=1);
	*/