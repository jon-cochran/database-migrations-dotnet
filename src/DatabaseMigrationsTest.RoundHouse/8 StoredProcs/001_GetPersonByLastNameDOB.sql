IF NOT EXISTS (SELECT * FROM sysobjects WHERE id = object_id(N'[dbo].[GetPersonByLastNameDOB]') 
 and OBJECTPROPERTY(id, N'IsProcedure') = 1 )	
     EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetPersonByLastNameDOB] 
     AS PRINT ''This is an empty stub version, to be replaced'''
GO

ALTER PROC [dbo].[GetPersonByLastNameDOB]
	@LastName nvarchar(255),
	@DOB datetime2(7)
AS
BEGIN
	SELECT * FROM dbo.Person
	WHERE LastName = @LastName
	AND DateOfBirth = @DOB
END