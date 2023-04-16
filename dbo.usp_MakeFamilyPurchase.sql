USE TSQL2012

GO
IF OBJECT_ID('dbo.usp_MakeFamilyPurchase','P') IS NOT NULL DROP PROCEDURE dbo.usp_MakeFamilyPurchase

GO
CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
@FamilySurName varchar(255)
AS
DECLARE @ID_F INT= (SELECT F.ID_Family FROM dbo.Family AS F WHERE F.SurName=@FamilySurName)

IF @ID_F IS NULL
SELECT 'Ошибка, введенная семья отсутствует в базе данных!'

ELSE
DECLARE @SUM_V DECIMAL(18,2)=(SELECT SUM(B.Value) FROM dbo.Basket AS B 
							  WHERE B.ID_Family=@ID_F)
BEGIN
UPDATE dbo.Family 
SET dbo.Family.BudgetValue = CAST(@SUM_V AS MONEY)
WHERE dbo.Family.ID_Family=@ID_F
END
GO