CREATE PROC pr_fill_tables1
	@count INT
AS
BEGIN

-- заполнение первой таблицы --
	DECLARE @CountTable INT, @i INT
	SET @CountTable = 100
	SET @i = 0
	WHILE @i < @CountTable
	BEGIN
		INSERT INTO [dbo].[Genre]([Name], IsDeleted)
		VALUES ('Genre_' + CAST(@i as nvarchar),0)

		SET @i = @i + 1
	END


-- заполнение второй таблицы --
	SET @i = 0
	DECLARE @GenreId UNIQUEIDENTIFIER
	DECLARE @Year INT
	DECLARE @Pages INT


	WHILE @i < @CountTable
	BEGIN
		SET @Year = FLOOR(RAND() - (2025 - 1900) + 1900)
		SET @Pages = FLOOR(RAND() * 400) + 1
		SELECT TOP 1 @GenreId = Id FROM Genre ORDER BY NEWID()
		INSERT INTO [dbo].[Book](Genre_id, Title, Author, Publication_year, Pages, IsDeleted)
		VALUES (@GenreId, ('Title_' + CAST(@i as nvarchar)), ('Author_' + CAST(@i as nvarchar)), @Year, @Pages, 0)

		SET @i = @i + 1

	END

-- заполнение третьей таблицы --
	SET @i = 0
	DECLARE @BookId UNIQUEIDENTIFIER
	DECLARE @Price DECIMAL(10,2)

	WHILE @i < @count
	BEGIN
		SET @Price = FLOOR(RAND() * 100) + 1
		SELECT TOP 1 @BookId = Id FROM Book ORDER BY NEWID()
		INSERT INTO [dbo].[Book_store](Book_id, Price, IsDeleted)
		VALUES (@BookId, @Price, 0)

		SET @i = @i + 1
	END

END

EXEC pr_fill_tables1 @count = 1000
