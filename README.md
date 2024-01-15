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


## 1. Importing Data into Power BI 
 
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


## 2. Creating the Data Model
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

## 3. Setup Report
This step was quick but needed for the later steps. Inn the report view 4 separate pages were made:
1. Executive Summary
2. Customer Detail
3. Product Detail
4. Stores Map

Navigation bars were also added to each of the pages to later be worked on.

## 4.Creating Customer Detail Page 
1. **CARD VISUALS** - Added a Unique Customers Card visual

--> Using the [Total Customers] measure created earlier and renaming Unique Customers

Added a Revenue per Customer Card visual

--> Created a new measure in Measures Table: Revenue per Customer = [Total Revenue]/[Total Customers]. Then added this to a card visual

2. **SUMMARY CHARTS** - Added a Donut Chart visual showing the total customers for each country.  
--> Used the Users[Country] column to filter the [Total Customers] measure.

Add a Column Chart visual showing the number of customers who purchased each product category.     
--> Used the Products[Category] column to filter the [Total Customers] measure.

3. **LINE CHART** - Added a Line Chart visual to the top of the page.  
--> It shows [Total Customers] on the Y axis, and uses the Date Hierarchy we created previously for the X axis. Allow users to drill down to the month level and not any further.
*Added a trend line, and a forecast for the next 10 periods with a 95% confidence interval*

4. **TOP 20 CUSTOMER TABLE** - Created a new table which displays the top 20 customers filtered by revenue.  
-->The table shows show each customer's full name, revenue, and number of orders.  
*Also added conditional formatting to the revenue column, to display data bars for the revenue values and coloured them to an appropriate transparency.*

5. **TOP CUSTOMER VISUAL CARDS** - Created 3 Customer visual cards.   
- Top Customer  
- Top Customers Revenue   
- Top Customers Order count   
These were all formatted by filtering out the top revenue from the name list and then applying the column needed to produce the correct result after.

6. **DATE SLICER** - Added a date slicer.  
--> Used a between slicer style on the report page so are able to change years.

![Customer Detail page]("C:\Users\Ellie\Pictures\Screenshots\Screenshot20%2024-01-1120%231608.png")



## 5. Creating Executive Summary Page 
1. **CARD VISUALS**
Created three card visuals for Total Revenue, Total Orders and Total Profit measures.

2. **REVENUE TRENDING LINE**
Inserted a revenue trending line with forecast as in the previous customer detail page with X-axis as Date Hierarchy and Y-axis as Total Revenue.

3. **DONUT CHARTS FOR REVENUE BY COUNTRY AND STORE TYPE**
Added a pair of donut charts showing Total Revenue of Store Country and Story Type.

4. **BAR CHART OF ORDERS BY PRODUCT CATEGORY**
Built a clustered bar chart showing orders by product category. 

5. **KPI VISUALS**
- Created new measures (Previous Quarter: Profit, Revenue & Orders) and (Targets of 5% Growth: Profit, Revenue & Orders)
- Added KPI visuals with value = Total Revenue, Trend Axis = Start of Quarter, Target = Target Revenue 
- To format the KPI visuals in the format pane the direction was set to high is good, bad colour red and transparency at 15% as well as callout value only showing 1 decimal place instead of auto.

*INSERTED PICTURE OF PAGE*


## 6. Creating Product Detail Page 
1. **GAUGE VISUALS**
- Defined DAX measures for (Current Quarter: Orders,Revenue, Profit) and (Targets if 10% quarter on quarter growth for all three)
- Three gauge filters created with maximum value of gauge set to the Target measure.
- Conditional formatting applied for the callout value to change colour dependent on if target met. 
*INSERT SCREENSHOT HERE - CURRENTLY NOT WORKING AS A CONDITIONAL FORMATTING TOOL*

2. **AREA CHART OF REVENUE BY PRODUCT CATEGORY**
Area chart added with X-axis as Dates[Start of Quarter],Y-axis as Total revenue  and legend as Products categories.

3. **TOP PRODUCTS TABLE**
Top 10 products table added including: Product Description, Total Revenue, Total Customers,Total Orders, Profit per Order. 
- This was filtered by setting the Top N type as 10 based on revenue.

4. **SCATTER GRAPH OF QUANTITY SOLD VS PROFIT PER ITEM**
- New calculated column formed called [Profit per Item] in products table using DAX formula: Profit per Item = 'Products'[Sale Price] - 'Products'[Cost Price].
- Scatter chart formed including: Values as Products[Description],X-Axis as Prodcuts[Profit per Item], Y-Axis as Products[Total Quantity] and Legend as Products[Category]

5. **CREATE A SLICER TOOLBAR**
- Custom icons were preciously downloaded to be used for button icons. For this page a filter icon was inserted. 
- A blank button was inserted with tooltip text set to Open Slicer Panel as a direction instruction for users clicking on the button when functional.
- A larger rectangle shape than the normal navigation was made by copying the navigation bar and exapnding its width to an appropriate amount which would fit the slicers in.
- Two slicers were made one for Products[Category] and the other for Stores[Country].
For the product category slicer multiple items are able to be selcted but for country only one or a slect all option. 
- Next, a back button was inserted and was positioned in the toolbar at the top to be easily seen when the toolbar is opened.
- The bookmarks pane was then utilised. Two bookmarks were added one named 'Slicer Bar Closed' and the other 'Slicer Bar Opened'. The Slicer Bar Closed bookmark had the newly created toolbar hidden and both had the data option unchecked to prevent the bookmakr selections affecting the slicer state when toolbar closed. 

*INSERT PAGE SCREENSHOT*


## 7. Creating Store Map Page
1. **MAP VISUALS**
2. **COUNTRY SLICER**
3. **STORES DRILLTHROUGH PAGE**
4. **STORES TOOLTIPS PAGE**

## 8.CROSS-FILTERING AND NAVIGATION
1. **FIX CROSS FILTERING**
2. **FINISH NAVIGATION BAR**


## File Structure 
- README.md 
- Power_BI_Report.pbix

## License