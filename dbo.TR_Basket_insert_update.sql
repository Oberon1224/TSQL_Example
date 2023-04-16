USE TSQL2012

GO
IF OBJECT_ID('dbo.TR_Basket_insert_update','Tr') IS NOT NULL DROP TRIGGER dbo.TR_Basket_insert_update 

GO
CREATE TRIGGER TR_Basket_insert_update
ON dbo.Basket AFTER  INSERT
AS SET NOCOUNT OFF

BEGIN
UPDATE dbo.Basket
SET DiscountValue=Value*0.05
WHERE ID_Basket IN (SELECT ID_Basket FROM inserted 
					WHERE ID_SKU IN (SELECT ID_SKU FROM inserted 
					                 GROUP BY ID_SKU 
									 HAVING COUNT(ID_SKU)>=2)
					GROUP BY ID_Basket)
UPDATE dbo.Basket
SET DiscountValue=0
WHERE ID_Basket IN (SELECT ID_Basket FROM inserted 
					WHERE ID_SKU IN (SELECT ID_SKU FROM inserted 
					                 GROUP BY ID_SKU 
									 HAVING COUNT(ID_SKU)=1)
					GROUP BY ID_Basket)
END
GO

