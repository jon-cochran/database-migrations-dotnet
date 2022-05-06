USE Migrations_RoundHouse
GO

CREATE OR ALTER TRIGGER [dbo].[trg_Person_Audit]
	ON [dbo].[Person] FOR INSERT, UPDATE, DELETE AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON

	DECLARE @TableName varchar(128);
  	DECLARE @AuditTableName varchar(128);
	DECLARE @Action char(1)
	DECLARE @User varchar(128);
	DECLARE @CreatedOn varchar(21);
	DECLARE @HostName varchar(256);
	DECLARE @beforeJson NVARCHAR(MAX);
	DECLARE	@afterJson NVARCHAR(MAX);

	-- Define the Table and the History Table
 	SET @TableName = 'Person';
  	SET @AuditTableName = 'AuditResults';

	-- Check trigger status before executing
  	IF NOT EXISTS (SELECT * FROM [audit].AuditedTables WHERE TableName = @TableName AND AuditTable = @AuditTableName AND IsEnabled = 1)
  		RETURN;  --trigger has been disabled 
	 
	-- Set the Audit Action
	IF EXISTS (SELECT * FROM inserted)
	IF EXISTS (SELECT * FROM deleted)
		SET @Action = 'U';
	ELSE
		SET @Action = 'I';
	ELSE
		SET @Action = 'D';


	-- Set the User (No Domain)
 	IF CHARINDEX('\', SYSTEM_USER) <> 0
 		BEGIN
 				SELECT @User = SUBSTRING(SYSTEM_USER, CHARINDEX('\', SYSTEM_USER) + 1, LEN(SYSTEM_USER));
		END
	ELSE
		BEGIN
				SELECT @User = SYSTEM_USER; 						
		END


	SELECT @CreatedOn = CONVERT(VARCHAR(8), GETDATE(), 112) + ' ' + CONVERT(VARCHAR(12), GETDATE(), 114);
	SELECT @HostName = CAST(HOST_NAME() as varchar(256));

	SET @beforeJson = (SELECT * FROM DELETED FOR JSON AUTO);
	SET @afterJson = (SELECT * FROM INSERTED FOR JSON AUTO);

	INSERT INTO [audit].[AuditResults]
	(	
		[TableName],	
		[Action],
		[Before],
		[After],		
		[AuditDate],
		[User],
		[HostName]
	)
	SELECT 		
		@TableName,
		@Action,
		@beforeJson AS [Before],
		@afterJson AS [After],	
		@CreatedOn,
		@User,
		@HostName	
		
END
GO





