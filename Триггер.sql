CREATE TRIGGER tr_SoftDelete_Orders
ON Orders1
INSTEAD OF DELETE
AS
BEGIN
	UPDATE o
	SET o.IsDeleted = 1
      o.DeletedDate = GETDATE()
	FROM Orders1 o
	INNER JOIN deleted d ON o.Id = d.Id
END
