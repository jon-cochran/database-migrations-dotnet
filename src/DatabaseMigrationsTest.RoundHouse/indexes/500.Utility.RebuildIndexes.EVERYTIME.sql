USE Migrations_RoundHouse
GO

DECLARE @TableName VARCHAR(255)
	,@sql NVARCHAR(500)
	,@fillfactor INT

SET @fillfactor = 80 

DECLARE @TblList TABLE (
	[TNum]		int	identity(1,1)
	,[FQN]		nvarchar(300)
	)

INSERT @TblList
SELECT [TABLE_SCHEMA] + '.' + [TABLE_NAME] as [FQN]
FROM [INFORMATION_SCHEMA].[TABLES]
WHERE [TABLE_SCHEMA] != 'RoundhousE'
	and [TABLE_TYPE] = 'BASE TABLE'

DECLARE @C int
SELECT @C = MIN([TNum])
FROM @TblList

WHILE @C is not NULL
BEGIN

	SELECT @sql = 'ALTER INDEX ALL ON ' + [FQN] + ' REBUILD WITH (FILLFACTOR = ' + CONVERT(VARCHAR(3),@fillfactor) + ')'
	FROM @TblList
	WHERE [TNum] = @C

	EXEC (@sql)

	SELECT @C = MIN([TNum])
	FROM @TblList
	WHERE [TNum] > @C

END
