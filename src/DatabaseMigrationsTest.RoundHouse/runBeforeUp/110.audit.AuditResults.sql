USE Migrations_RoundHouse
GO
IF NOT EXISTS (SELECT TOP 1 * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'AuditResults' and TABLE_SCHEMA = 'audit')
BEGIN
	
	CREATE TABLE [audit].[AuditResults] (
		[AuditID] [int] IDENTITY(1,1) NOT NULL,
		[AuditAction] [char](1) NULL,
		[TableName] [varchar](128) NULL,
		[PrimaryKeyField] [varchar](500) NULL,
		[PrimaryKeyValue] [varchar](500) NULL,
		[FieldName] [varchar](128) NULL,
		[OldValue] [varchar](1000) NULL,
		[NewValue] [varchar](1000) NULL,
		[AuditDate] [datetime] NULL,
		[AuditUser] [varchar](128) NULL,
		[AuditHostName] [varchar](256) NULL
		)

END;

IF NOT EXISTS (
	SELECT * 
	FROM [INFORMATION_SCHEMA].[TABLE_CONSTRAINTS] 
	WHERE [CONSTRAINT_SCHEMA] = 'audit' 
		AND [CONSTRAINT_NAME] = 'PK_AuditResults'
		AND [CONSTRAINT_TYPE] = 'PRIMARY KEY'
	)
BEGIN

	ALTER TABLE [audit].[AuditResults]
		ADD CONSTRAINT PK_AuditResults PRIMARY KEY CLUSTERED ([AuditID]);

END;

IF NOT EXISTS (
	SELECT [name] from sys.default_constraints
	WHERE parent_object_id = OBJECT_ID(N'[audit].[AuditResults]')
		AND ([name] = 'DF_AuditResults_AuditDate')
		)
BEGIN

	ALTER TABLE [audit].[AuditResults]
		ADD CONSTRAINT [DF_AuditResults_AuditDate] DEFAULT (getdate()) FOR [AuditDate];

END;
	