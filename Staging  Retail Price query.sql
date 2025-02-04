
-- Creating another table to put all the data set in, that's the staging table 
USE [Retail Price]
GO

/****** Object:  Table [dbo].[NonFood_Monthly$]    Script Date: 1/21/2025 5:00:20 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[NonFood_Monthly$_staging](
	[State] [nvarchar](255) NULL,
	[Centre] [nvarchar](255) NULL,
	[Commodity] [nvarchar](255) NULL,
	[Variety] [nvarchar](255) NULL,
	[Unit] [nvarchar](255) NULL,
	[Category] [nvarchar](255) NULL,
	[Date] [datetime] NULL,
	[Retail Price] [nvarchar](255) NULL
) ON [PRIMARY]
GO


Select * from [dbo].[NonFood_Monthly$_staging]
INSERT [dbo].[NonFood_Monthly$_staging]
SELECT * 
FROM [dbo].[NonFood_Monthly$]

INSERT INTO [dbo].[NonFood_Monthly$_staging]
SELECT * 
FROM [dbo].[NonFood_Monthly$];

-----1 
-- Starting data cleaning from the staging table

-- removing duplicates 

SELECT  * , 
ROW_NUMBER() OVER(
PARTITION BY State, Centre, Commodity, Variety, Unit, Category,[Retail Price],[Date]
ORDER BY [Date]) AS row_num
FROM [dbo].[NonFood_Monthly$_staging];


WITH duplicate_cte AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY State, Centre, Commodity, Variety, Unit, Category, [Retail Price], [Date]
               ORDER BY [Date]
           ) AS row_num
    FROM [dbo].[NonFood_Monthly$_staging]
)
DELETE FROM [dbo].[NonFood_Monthly$_staging]
WHERE [State] IN (
    SELECT [State]
    FROM duplicate_cte
    WHERE row_num > 1
)
 SELECT COUNT(*) AS TotalRows FROM [dbo].[NonFood_Monthly$_staging];


 -- checking if the duplicates were removed
 SELECT State, Centre, Commodity, Variety, Unit, Category, [Retail Price], [Date], COUNT(*)
FROM [dbo].[NonFood_Monthly$_staging]
GROUP BY State, Centre, Commodity, Variety, Unit, Category, [Retail Price], [Date]
HAVING COUNT(*) > 1;

-- If multiple rows in the staging table share the same Category but differ in other attributes (e.g., State, Centre), the condition inadvertently deletes all rows with that Category.

-----2 
-- checking for NULL values 
SELECT COUNT(*) AS NullRetailPriceCount
FROM [dbo].[NonFood_Monthly$_staging]
WHERE [Retail Price] IS NULL;


-- replacing null values in retail price with the median based on the commodity
SELECT COUNT(*) AS NullRetailPriceCount
FROM [dbo].[NonFood_Monthly$_staging]
WHERE [Retail Price] IS NULL;

WITH MedianPrices AS (
    SELECT
        Commodity,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CAST([Retail Price] AS FLOAT)) 
        OVER (PARTITION BY Commodity) AS MedianPrice
    FROM [dbo].[NonFood_Monthly$_staging]
    WHERE [Retail Price] IS NOT NULL
)
UPDATE NF
SET [Retail Price] = MP.MedianPrice
FROM [dbo].[NonFood_Monthly$_staging] NF
JOIN MedianPrices MP
    ON NF.Commodity = MP.Commodity
WHERE NF.[Retail Price] IS NULL;
 
 SELECT * 
 FROM  [dbo].[NonFood_Monthly$_staging]


 WITH ModeVariety AS (
    SELECT TOP 1
        Variety
    FROM [dbo].[NonFood_Monthly$_staging]
    WHERE [Variety] IS NOT NULL
    GROUP BY Variety
    ORDER BY COUNT(*) DESC
)
UPDATE NF
SET [Variety] = MV.Variety
FROM [dbo].[NonFood_Monthly$_staging] NF
JOIN ModeVariety MV
    ON 1 = 1  -- This makes sure all rows are updated with the mode
WHERE NF.[Variety] IS NULL;


---- Removing the time from the date column
SELECT CONVERT(DATE, [Date]) AS Date
FROM   [dbo].[NonFood_Monthly$_staging];

UPDATE [dbo].[NonFood_Monthly$_staging]
SET [Date] = CAST([Date] AS DATE);

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'NonFood_Monthly$_staging' AND COLUMN_NAME = 'Date';

ALTER TABLE [dbo].[NonFood_Monthly$_staging]
ALTER COLUMN [Date] DATE;

 SELECT * 
 FROM  [dbo].[NonFood_Monthly$_staging]


-- FOR Food_Monthly_Staging

 USE [Retail Price]
GO

/****** Object:  Table [dbo].[Food_Monthly]    Script Date: 1/22/2025 9:33:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Food_Monthly_staging](
	[State] [varchar](100) NULL,
	[Center] [varchar](100) NULL,
	[Commodity] [varchar](100) NULL,
	[Variety] [varchar](100) NULL,
	[Unit] [varchar](50) NULL,
	[Category] [varchar](50) NULL,
	[Date] [date] NULL,
	[Retail_Price] [decimal](10, 2) NULL
) ON [PRIMARY]
GO


-- Select all rows from the staging table
SELECT *
FROM [dbo].[Food_Monthly_staging];

-- Insert data from [Food_Monthly] into [Food_Monthly_staging]
INSERT INTO [dbo].[Food_Monthly_staging]
SELECT *
FROM [dbo].[Food_Monthly];

-- Verify the data in the original table
SELECT * 
FROM [dbo].[Food_Monthly];


-- Checking for duplicates and removing them
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY State, Centre, Commodity, Variety, Unit, Category, Date, [Retail Price]
           ORDER BY [Date]
       ) AS row_num
FROM [dbo].[Food_Monthly_staging])

WITH CTE_RowNumbers AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY State, Centre, Commodity, Variety, Unit, Category, Date, [Retail Price]
               ORDER BY [Date]
           ) AS row_num
    FROM [dbo].[Food_Monthly_staging]
)
DELETE FROM [dbo].[Food_Monthly_staging]
WHERE [State] IN (
    SELECT [State]
    FROM CTE_RowNumbers
    WHERE row_num > 1);

	-- Checking for any more duplicates
 SELECT State, Centre, Commodity, Variety, Unit, Category, [Retail Price], [Date], COUNT(*)
FROM [dbo].[Food_Monthly_staging]
GROUP BY State, Centre, Commodity, Variety, Unit, Category, [Retail Price], [Date]
HAVING COUNT(*) > 1;

SELECT *
FROM [dbo].[Food_Monthly_staging]


--  Checking for empty values and filing with null
SELECT COUNT(*) AS NullVariety
FROM [dbo].[Food_Monthly_staging]
WHERE Variety IS NULL;

-- Check for empty strings
SELECT COUNT(*) AS EmptyVariety
FROM [dbo].[Food_Monthly_staging]
WHERE Variety = '';

UPDATE [dbo].[Food_Monthly_staging]
SET Variety = NULL
WHERE Variety = '';

--- replacing variety with it median

 WITH ModeVariety AS (
    SELECT TOP 1
        Variety
    FROM [dbo].[Food_Monthly_staging]
    WHERE [Variety] IS NOT NULL
    GROUP BY Variety
    ORDER BY COUNT(*) DESC
)
UPDATE NF
SET [Variety] = MV.Variety
FROM [dbo].[Food_Monthly_staging] NF
JOIN ModeVariety MV
    ON 1 = 1  -- This makes sure all rows are updated with the mode
WHERE NF.[Variety] IS NULL;


-- counting retail price where value is empty
SELECT COUNT(*) AS EmptyRetailPrice
FROM [dbo].[Food_Monthly_staging]
WHERE [Retail Price] = '';

UPDATE [dbo].[Food_Monthly_staging]
SET [Retail Price] = NULL
WHERE [Retail Price] = '';


-- filling retail price with it median
WITH MedianPrices AS (
    SELECT
        Commodity,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY CAST([Retail Price] AS FLOAT)) 
        OVER (PARTITION BY Commodity) AS MedianPrice
    FROM [dbo].[Food_Monthly_staging]
    WHERE [Retail Price] IS NOT NULL
)
UPDATE NF
SET [Retail Price] = MP.MedianPrice
FROM [dbo].[Food_Monthly_staging] NF
JOIN MedianPrices MP
    ON NF.Commodity = MP.Commodity
WHERE NF.[Retail Price] IS NULL;