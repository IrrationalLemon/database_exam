CREATE PROC pr_PrintFirstLast_Order
AS
BEGIN
    DECLARE @FirstId UNIQUEIDENTIFIER, @LastId UNIQUEIDENTIFIER
    DECLARE @IsFirst BIT = 1
    DECLARE @CurrentId UNIQUEIDENTIFIER  -- Исправлено: правильное название переменной

    DECLARE cursor_order CURSOR FAST_FORWARD FOR
        SELECT Id FROM [dbo].[ActiveOrders]  -- Уточнено: выбираем только Id

    OPEN cursor_order
    FETCH NEXT FROM cursor_order INTO @CurrentId

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF @IsFirst = 1
        BEGIN
            SET @FirstId = @CurrentId  -- Исправлено: @CurrentId вместо @CurrenId
            SET @IsFirst = 0
        END
        ELSE
        BEGIN
            SET @LastId = @CurrentId  -- Исправлено: @CurrentId вместо @CurrenId
        END
        FETCH NEXT FROM cursor_order INTO @CurrentId
    END

    -- Выводим первую и последнюю запись
    SELECT * FROM ActiveOrders 
    WHERE Id = @FirstId OR Id = @LastId
    

    CLOSE cursor_order
    DEALLOCATE cursor_order
END
