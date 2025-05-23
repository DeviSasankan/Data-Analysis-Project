
SELECT * 
FROM 
	dbo.customer_reviews
--*******************************

SELECT 
	ReviewDate,
	CustomerID,
	ProductID,
	ReviewID,
	Rating,
	-- Cleaning the ReviewText column by replacing the double spaces with single spaces to ensure the text is more standardised
	REPLACE(ReviewText, '  ', ' ') AS ReviewText
FROM 
	dbo.customer_reviews
	