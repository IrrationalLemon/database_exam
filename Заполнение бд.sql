CREATE PROC Fill_the_Table
	@count INT
AS
BEGIN
	DECLARE @CountTable INT, @i INT
	SET @CountTable = 100
	SET @i = 0

	WHILE @i < @CountTable
	BEGIN
		INSERT INTO Customer([Name])
		VALUES ('Customer_' + CAST(@i AS nvarchar))
		
		INSERT INTO [Product]([Name])
		VALUES ('Product_' + CAST(@i AS nvarchar))
		
		SET @i = @i + 1
	END

	SET @i = 0
	DECLARE @CustomerId UNIQUEIDENTIFIER
	DECLARE @ProductId UNIQUEIDENTIFIER

	DECLARE @Quantity INT
	SET @Quantity = FLOOR(RAND() * 100) + 1

	DECLARE @Order_date DATE
	SET @Order_date = CAST(GETDATE() AS DATE)

	DECLARE @Price DECIMAL(10, 2)
	SET @Price = FLOOR(RAND() * 100) + 1

	WHILE @i < @Count
	BEGIN
		SELECT TOP 1 @CustomerId = Id FROM Customer ORDER BY NEWID()
		SELECT TOP 1 @ProductId = Id FROM [Product] ORDER BY NEWID()

		INSERT INTO Orders1(Quantity, Order_date, Price, Customer_id, Product_id, IsDeleted)
		VALUES (@Quantity, @Order_date, @Price, @CustomerId, @ProductId, 0)

		SET @i = @i + 1
	END
END
