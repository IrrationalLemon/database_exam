CREATE PROC pr_FirstAndLast_row
AS
BEGIN
	DECLARE @FirstId UNIQUEIDENTIFIER, @LastId UNIQUEIDENTIFIER
	DECLARE @CurrentId UNIQUEIDENTIFIER
	DECLARE @isFirst BIT = 1

	DECLARE Book_cursor CURSOR FOR
	SELECT Id FROM [dbo].[Book]
	
	OPEN Book_cursor
	FETCH NEXT FROM Book_cursor INTO @CurrentId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @isFirst = 1
		BEGIN
			SET @FirstId = @CurrentId
			SET @isFirst = 0
		END
		ELSE
		BEGIN
			SET @LastId = @CurrentId
		END
		FETCH NEXT FROM Book_cursor INTO @CurrentId
	END

	SELECT * FROM Book WHERE Id = @FirstId OR Id = @LastId
	CLOSE Book_cursor
	DEALLOCATE Book_cursor

END
