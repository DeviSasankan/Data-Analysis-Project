
SELECT *
FROM
	dbo.engagement_data

--Clean and normalise the ENGAEMENT_DATA table


SELECT 
	EngagementID,
	ContentID,
	CampaignID,
	ProductID,
	UPPER(REPLACE(ContentType, 'SOCIALMEDIA', 'Social Media')) AS ContentType,
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined)- 1) AS Views,
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks,
	Likes,
	--Converting EngagementDate format to dd.MM.yyy
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyyy') AS EngagementDate
FROM 
	dbo.engagement_data
WHERE 
	ContentType != 'Newsletter'; -- Filtering out rows where ContentType as NewsLetter as they are not relevant for the analysis