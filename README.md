# Retail Price Analysis of Commodities (Food & Non-Food)

## Project Overview
This project analyzes the retail prices of various commodities, including food and non-food items, across different states and market centers in India. The dataset consists of weekly and monthly price records for commodities such as fruits, vegetables, clothes, and other consumer goods. 

The analysis is structured into two major categories:
1. **Food Commodities Dashboard**
2. **Non-Food Commodities Dashboard**

## Data Source & Preprocessing
The dataset contains several missing values, requiring extensive data cleaning before analysis. The key attributes include:
- **State**: Indian state (e.g., Maharashtra, Madhya Pradesh, Rajasthan, etc.)
- **Center**: Market center (e.g., Mumbai, Pune, Bangalore, etc.)
- **Commodity**: Name of the commodity (e.g., Fish, Apple, Dhoti, Saree, Ghee, etc.)
- **Variety**: Subtype of the commodity (e.g., "Delicious Medium Size" for apples)
- **Unit**: Measurement unit (e.g., Kg, Litre, Dozens, etc.)
- **Category**: Classification as Food or Non-Food
- **Date**: The reporting period (weekly or monthly)
- **Retail Price**: Price of the commodity in rupees

### Data Cleaning Process
- **Handled missing values**: Imputed or removed missing records to ensure consistency
- **Standardized formats**: Unified date formats and measurement units
- **Filtered anomalies**: Removed extreme outliers affecting pricing trends
- **SQL Queries**: Performed data cleaning using structured SQL queries for efficient preprocessing

## Dashboard Analysis
The cleaned data was visualized using Power BI to generate two dashboards:

### Food Commodities Dashboard
![Screenshot 2025-01-23 204005](https://github.com/user-attachments/assets/9b35d42e-6fcf-4ff0-9189-bc9259ff6be4)


#### Key Insights:
- **Price Variations**: Significant fluctuations in prices across different states.
- **Seasonal Trends**: Certain commodities exhibit periodic price increases, likely due to seasonal demand.
- **Regional Differences**: Some states consistently report higher prices for the same commodities compared to others.

### Non-Food Commodities Dashboard
![Screenshot 2025-01-25 124225](https://github.com/user-attachments/assets/a12acbfc-c972-4eae-aa5e-c4b4ecaf7f36)


#### Key Insights:
- **Price Stability**: Compared to food items, non-food commodity prices tend to be more stable over time.
- **High-Value Items**: Certain clothing and consumer goods have a higher retail price due to demand and production costs.
- **Market Center Influence**: Prices vary significantly between metropolitan and non-metropolitan centers.

## Tools & Technologies Used
- **SQL**: Data cleaning, transformation, and structuring.
- **Power BI**: Dashboard creation for data visualization.
- **Excel**: Preliminary data validation and formatting.

## Challenges & Learnings
- Combining both dashboards into a single visualization was complex due to the differences in price distributions and categories.
- SQL-based preprocessing was crucial for ensuring clean and usable data.
- Power BI allowed for interactive and insightful visualizations to compare trends between food and non-food commodities.

## Conclusion
This project provides a detailed overview of retail price fluctuations across India for food and non-food commodities. By leveraging SQL for data cleaning and Power BI for visualization, we derived meaningful insights that can aid businesses, policymakers, and consumers in making informed decisions.

