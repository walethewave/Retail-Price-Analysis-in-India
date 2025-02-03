CREATE TABLE Food_Weekly (
    State VARCHAR(100),
    Center VARCHAR(100),
    Commodity VARCHAR(100),
    Variety VARCHAR(100),
    Unit VARCHAR(50),
    Category VARCHAR(50),
    Date DATE,
    Retail_Price DECIMAL(10, 2)
);


-- Table for Food_Monthly
CREATE TABLE Food_Monthly (
    State VARCHAR(100),
    Center VARCHAR(100),
    Commodity VARCHAR(100),
    Variety VARCHAR(100),
    Unit VARCHAR(50),
    Category VARCHAR(50),
    Date DATE,
    Retail_Price DECIMAL(10, 2)
);




-- Table for NonFood_Weekly
CREATE TABLE NonFood_Weekly (
    State VARCHAR(100),
    Center VARCHAR(100),
    Commodity VARCHAR(100),
    Variety VARCHAR(100),
    Unit VARCHAR(50),
    Category VARCHAR(50),
    Date DATE,
    Retail_Price DECIMAL(10, 2)
);


-- Table for NonFood_Monthly
CREATE TABLE NonFood_Monthly (
    State VARCHAR(100),
    Center VARCHAR(100),
    Commodity VARCHAR(100),
    Variety VARCHAR(100),
    Unit VARCHAR(50),
    Category VARCHAR(50),
    Date DATE,
    Retail_Price DECIMAL(10, 2)
);

--  Data Cleaning on the NonFood_Monthly$ Table

SELECT  [State]
      ,[Centre]
      ,[Commodity]
      ,[Variety]
      ,[Unit]
      ,[Category]
      ,[Date]
      ,[Retail Price]
  FROM [Retail Price].[dbo].[NonFood_Monthly$]

SELECT TOP 0 *
INTO NonFood_Monthly_staging
FROM [Retail Price].[dbo].[NonFood_Monthly$];

SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'NonFood_Monthly_staging';


