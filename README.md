# Data Analytics Power BI Report

This is a project for AiCore which involves a number of different tasks using PowerBI.

## Contents 
1. Description
2. Installation Instructions
3. Usage Instructions
4. File Structure 
5. License


## Description
Project objective: 
> You have recently been approached by a medium-sized international retailer who is keen on elevating their business intelligence practices. With operations spanning across different regions, **they've accumulated large amounts of sales from disparate sources over the years**.
Recognizing the value of this data, they aim to transform it into actionable insights for better decision-making. Your goal is to ****use Microsoft Power BI to design a comprehensive Quarterly report. This will involve extracting and transforming data from various origins, designing a robust data model rooted in a star-based schema, and then constructing a multi-page report.**
The report will present a high-level business summary tailored for C-suite executives, and also give insights into their highest value customers segmented by sales region, provide a detailed analysis of top-performing products categorised by type against their sales targets, and a visually appealing map visual that spotlights the performance metrics of their retail outlets across different territories."



## Installation Instructions 
Clone the repository into a terminal using the below command:
```
git clone https://github.com/elliesgithub/data-analytics-power-bi-report762.git
```


## Usage Instructions


### Importing Data into Power BI 

> [!NOTE]
> The computer being used for this project is a mac which does not support the use of PowerBI desktop. In this case a Azure Virtual Machine was setup to run windows as the dedicated environment to run Power BI. The virtual machine was provisioned and connected to from the local machine. As a mac user you can then connect to the Azure windows VM using the Remote Desktop Protocol. In this case, Microsoft Remote Desktop was used to establish the connection and installed Power BI desktop for windows.**To upload documentation for each step of the project I downloaded VScode on the VM but this could also be pushed using git bash in the terminal**

For each of these steps unused columns were removed and column names adjusted to suit Power BI naming conventions.


**1. Load and Transform Orders Table (Azure SQL Database connection)**
Connected to an Azure SQL Database and imported the orders_powerbi table.
- In this step the column [Card Number] was deleted for data privacy. Shipping and order columns were split into date and time respective columns and null data was filtered out of the [Order Date] column.

**2. Import and Transform Products Table** 
Downloaded a provided Products.csv file to local machine and used the get data function to import into Power BI.
- Removed duplicates in the [product_code column]
- Used the weight column to create separate unit and value columns. Used the columns from example function then adjusted the M expression for numbers which weren't accounted for in the first 100 examples of the weight column. 
- The values column was converted to decimal type. Anny errors which occured were replaced with the value of 1.
- The unit column had any blank entries replaced with kg.
- Finally another column was made which adjusts the values to kg.


**3. Import and Transform Stores Table**
Connect to an Azure Blob Storage using Power BI Get Data function.
- Nothing was adjusted on this table.

**4. Import and Transform Customers Table**
Download a provided Customers.zip file and unzip it to the local machine.
- The folder contained three separate files with the same format containing information about different regions.
- Used Combine and transform to download the files into the Power BI.
- A [full name] column was then added by combining the first and last  name columns in the table.


### Creating the Data Model
**1. Created Date Table**
![Creating Date Table]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20163602.png")
Firstly, a dates table was created with above DAX formula.

Below are the columns added with some examples of the DAX formulas used:
- Day of Week
![Day of week]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20165038.png")
- Month Number (i.e. Jan = 1, Dec = 12 etc.)
![Month Number]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20165155.png")
- Month Name
![Month Name]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20165242.png")
- Quarter
![Quarter]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20165311.png")
- Year
![Year]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20165331.png")
- Start of Year
![Start of year]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20164754.png")
*same formatting for start of Quarter and Month*
- Start of Quarter
- Start of Month
- Start of Week
![Start of week]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20164839.png")

Each of these columns were added with DAX formulas.

**2. Built the Star Schema Data Model**
Next, the Star Schema Data Model was produced. Relationships were created between these columns in different tables:
- Orders[product_code] to Products[product_code]
- Orders[Store Code] to Stores[store code]
- Orders[User ID] to Customers[User UUID]
- Orders[Order Date] to Date[date]
- Orders[Shipping Date] to Date[date]

![Star Schema]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20165547.png")

**3. Create Measures table and Create Key Measures**
A measures table was made to manage the measures yet to be created. The table was made in Model view using the Power Query Editor. The measures were then created:
- Total Orders = COUNTROWS(Orders) 
- Total Revenue = SUMX(Orders, Orders[Product Quantity] * RELATED(Products[Sale Price]))
- Total Profit = SUMX(Orders, (RELATED(Products[Sale Price]) - RELATED(Products[Cost Price])) * Orders[Product Quantity])
- Total Customers = COUNTROWS(VALUES(Orders[User ID]))
- Total Quantity = SUM(Orders[Product Quantity])
- Profit YTD = TOTALYTD([Total Profit], Orders[Order Date])
- Revenue YTD = TOTALYTD([Total Revenue], Orders[Order Date]) 

**4. Create Date and Geography Hierarchies**
Date Hierarchy
![Date Hierarchy]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20171228.png")

A new column was created which creates a full country name for the United States, United Kingdom and Germany from the [Country Code] column.
![Country Column]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20171331.png")

Another calculated column was created combining Stores[Country Region], and Stores[Country] columns, separated by a comma and a space.
![Geography Column]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20171824.png")

Geography Hierarchy 
![Goegraphy Hierarchy]("C:\Users\Ellie\Pictures\Screenshots\Screenshot%202024-01-11%20172047.png")


## File Structure 
README.md 
Power_BI_Report.pbix

## License