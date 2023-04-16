USE TSQL2012

GO
IF OBJECT_ID('dbo.vw_SKUPrice','v') IS NOT NULL DROP VIEW dbo.vw_SKUPrice

GO
CREATE VIEW dbo.vw_SKUPrice AS
SELECT S.ID_SKU,S.Code,S.Name, dbo.udf_GETSKUPrice(S.ID_SKU) AS Price
FROM dbo.SKU AS S