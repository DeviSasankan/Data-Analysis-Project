
SELECT *
FROM dbo.customer_journey;
--*************************************

-- Common Table Expression (CTE) to idetify and tag duplicate records

WITH DuplicateRecord AS (
	SELECT 
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		-- Use ROW_NUMBER() TO assign a unique row number to each record within the partition defined below
		ROW_NUMBER() OVER (
			-- PARTITION BY groups the row based on the specified columns that should be unique
			PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
			ORDER BY JourneyID
		) AS row_num 
	FROM dbo.Customer_journey
)

SELECT *
FROM DuplicateRecord
WHERE row_num > 1
ORDER BY JourneyID

-- Outer query selects the final cleaned and standardised data

SELECT 
    JourneyID,  
    CustomerID, 
    ProductID,  
    VisitDate,  
    Stage,  
    Action, 
    COALESCE(Duration, avg_duration) AS Duration 
FROM 
    (
        -- Subquery to process and clean the data
        SELECT 
            JourneyID,  
            CustomerID, 
            ProductID,  
            VisitDate,  
            UPPER(Stage) AS Stage,  
            Action,  
            Duration,  
            AVG(Duration) OVER (PARTITION BY VisitDate) AS avg_duration,  
            ROW_NUMBER() OVER (
                PARTITION BY CustomerID, ProductID, VisitDate, UPPER(Stage), Action 
                ORDER BY JourneyID  
            ) AS row_num  
        FROM 
            dbo.customer_journey 
    ) AS subquery  
WHERE 
    row_num = 1;