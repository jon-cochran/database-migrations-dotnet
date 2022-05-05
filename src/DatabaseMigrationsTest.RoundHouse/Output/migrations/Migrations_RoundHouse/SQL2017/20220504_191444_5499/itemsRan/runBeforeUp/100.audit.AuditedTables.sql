USE Migrations_RoundHouse
GO
IF NOT EXISTS (SELECT TOP 1 * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AuditedTables' and TABLE_SCHEMA = 'audit')
BEGIN
	
	CREATE TABLE [audit].[AuditedTables] (
		[AuditedTablesId]	int identity(1,1)
		,[TableName] [varchar](50)
		,[AuditTable] [varchar](50)
		,[IsEnabled] [bit]
		)

END;

IF NOT EXISTS (
	SELECT * 
	FROM [INFORMATION_SCHEMA].[TABLE_CONSTRAINTS] 
	WHERE [CONSTRAINT_SCHEMA] = 'audit' 
		AND [CONSTRAINT_NAME] = 'PK_AuditedTables'
		AND [CONSTRAINT_TYPE] = 'PRIMARY KEY'
	)
BEGIN

	ALTER TABLE [audit].[AuditedTables]
		ADD CONSTRAINT PK_AuditedTables PRIMARY KEY CLUSTERED ([AuditedTablesId]);

END;

IF NOT EXISTS (
	SELECT [name] from sys.default_constraints
	WHERE parent_object_id = OBJECT_ID(N'[audit].[AuditedTables]')
		AND ([name] = 'DF_AuditedTables_IsEnabled')
		)
BEGIN

	ALTER TABLE [audit].[AuditedTables]
		ADD CONSTRAINT [DF_AuditedTables_IsEnabled] DEFAULT ((1)) FOR [IsEnabled];

END;
	