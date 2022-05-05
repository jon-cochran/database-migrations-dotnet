USE Migrations_RoundHouse
GO
IF NOT EXISTS (SELECT TOP 1 * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vPerson' 
 and TABLE_SCHEMA = 'dbo')
	EXEC dbo.sp_executesql @statement = N'CREATE VIEW dbo.vPerson 
        AS SELECT ''This is a stub View, to be replaced'' AS C1'
GO

ALTER VIEW dbo.vPerson
AS
SELECT P.[PersonId],
		P.[FirstName],
		P.[LastName],
		P.[DateOfBirth]
FROM dbo.Person as P