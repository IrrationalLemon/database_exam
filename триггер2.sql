-- 1 --
CREATE TRIGGER tr_Delete_Genre
ON [dbo].[Genre]
INSTEAD OF DELETE
AS
BEGIN
	UPDATE g
	SET g.IsDeleted = 1,
		g.DeletedDate = GETDATE()
	FROM [dbo].[Genre] g
	INNER JOIN deleted d ON g.Id = d.Id
END

-- 2 --
CREATE TRIGGER tr_Delete_Book
ON Book
INSTEAD OF DELETE
AS
BEGIN
	UPDATE b
	SET b.IsDeleted = 1,
		b.DeletedDate = GETDATE()
	FROM Book b
	INNER JOIN deleted d ON b.Id = d.Id
END

-- 3 --
CREATE TRIGGER tr_Delete_Store
ON [dbo].[Book_store]
INSTEAD OF DELETE
AS
BEGIN
	UPDATE s
	SET s.IsDeleted = 1,
		s.DeletedDate = GETDATE()
	FROM Book_store s
	INNER JOIN deleted d ON s.Id = d.Id
END
