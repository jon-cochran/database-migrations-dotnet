USE Migrations_RoundHouse
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name='idx_LastNameDOB'
  AND object_id = OBJECT_ID('[dbo].[Person]'))
BEGIN
  
  CREATE NONCLUSTERED INDEX [idx_LastNameDBO] on [dbo].[Person] ([LastName], [DateOfBirth])

END