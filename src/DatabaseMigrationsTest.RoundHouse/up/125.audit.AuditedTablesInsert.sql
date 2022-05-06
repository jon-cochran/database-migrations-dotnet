USE Migrations_RoundHouse
GO


INSERT [audit].[AuditedTables] ([TableName], [AuditTable], [IsEnabled])
VALUES 
	('Person', 'AuditResults', 1)
