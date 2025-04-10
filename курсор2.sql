CREATE PROC pr_FirstAndLastCustomer
AS
BEGIN
	DECLARE @FirstId UNIQUEIDENTIFIER, @LastId UNIQUEIDENTIFIER
	DECLARE @CurrentId UNIQUEIDENTIFIER
	DECLARE @IsFirst BIT = 1

	DECLARE customer_cursor CURSOR FAST_FORWARD FOR
		SELECT Id FROM ActiveCustomers -- представление

	OPEN customer_cursor
	FETCH NEXT FROM customer_cursor INTO @CurrentId

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @IsFirst = 1
		BEGIN
			SET @FirstId = @CurrentId
			SET @IsFirst = 0
		END
		ELSE
		BEGIN
			SET @LastId = @CurrentId
		END
		FETCH NEXT FROM customer_cursor INTO @CurrentId
	END

	SELECT * FROM ActiveCustomers WHERE Id = @FirstId OR Id = @LastId
	CLOSE customer_cursor
	DEALLOCATE customer_cursor
END
