
SELECT * 
FROM 
	dbo.products
--**********************************************************************

--Adding new column to the PRODUCTS table PriceCategory for a better view for the SHs

SELECT 
	ProductID,
	ProductName,
	Price,
	
	CASE
		WHEN Price < 50 THEN 'Low'
		WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory

FROM dbo.products


