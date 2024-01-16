# <ins>Data Analytics Power BI Report</ins>

This is a project for AiCore which involves a number of different tasks using PowerBI.
<a name="top"/> 

![Power BI image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/551077bf-1faa-4eb4-b116-4a5dbb92e9b1)

## Contents 
1. Description
2. Installation Instructions
3. Project tasks 
   - Importing Data into Power BI
   - Creating the Data Model
   - Setup Report
   - Creating Customer Detail Page
   - Creating Executive Summary Page
   - Creating Product Detail Page
   - Creating Stores Map Page (and drillthrough pages)
   - Cross-Filtering and Navigation
   - Creating Metrics for Users Outside the Company Using SQL
4. File Structure 
5. License


## Description
Project objective: 
> You have recently been approached by a medium-sized international retailer who is keen on elevating their business intelligence practices. With operations spanning across different regions, **they've accumulated large amounts of sales from disparate sources over the years**.
Recognizing the value of this data, they aim to transform it into actionable insights for better decision-making. Your goal is to **use Microsoft Power BI to design a comprehensive Quarterly report. This will involve extracting and transforming data from various origins, designing a robust data model rooted in a star-based schema, and then constructing a multi-page report.**
The report will present a high-level business summary tailored for C-suite executives, and also give insights into their highest value customers segmented by sales region, provide a detailed analysis of top-performing products categorised by type against their sales targets, and a visually appealing map visual that spotlights the performance metrics of their retail outlets across different territories."

## Installation Instructions 
Clone the repository into a terminal using the below command:
```
git clone https://github.com/elliesgithub/data-analytics-power-bi-report762.git
```
The Power_BI_Report.pbix contains the PowerBI Report with the different pages and the files in the Querying Database Questions answer the questions at the end of this README.md file.

## Project Tasks


## Importing Data into Power BI 
 
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


## Creating the Data Model
**1. Created Date Table**
Firstly, a dates table was created with above DAX formula.

Below are the columns added with some examples of the DAX formulas used:
- Day of Week
- Month Number (i.e. Jan = 1, Dec = 12 etc.)
- Month Name
- Quarter
- Year
- Start of Year
*same formatting for start of Quarter and Month*
- Start of Quarter
- Start of Month
- Start of Week

Each of these columns were added with DAX formulas.

**2. Built the Star Schema Data Model**   
Next, the Star Schema Data Model was produced. Relationships were created between these columns in different tables:
- Orders[product_code] to Products[product_code]
- Orders[Store Code] to Stores[store code]
- Orders[User ID] to Customers[User UUID]
- Orders[Order Date] to Date[date]
- Orders[Shipping Date] to Date[date]

![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/84965980-7535-4b6f-a896-3f149096eba8)


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
- Date Hierarchy was set up.

- A new column was created which creates a full country name for the United States, United Kingdom and Germany from the [Country Code] column.

- Another calculated column was created combining Stores[Country Region], and Stores[Country] columns, separated by a comma and a space.

- Geography Hierarchy was set up.


## Setup Report   
This step was quick but needed for the later steps. In the report view 4 separate pages were made:
1. Executive Summary
2. Customer Detail
3. Product Detail
4. Stores Map

Navigation bars were also added to each of the pages to later be worked on.

## Creating Customer Detail Page   
1. **CARD VISUALS** - Added a Unique Customers Card visual

- Using the [Total Customers] measure created earlier and renaming Unique Customers

- Added a Revenue per Customer Card visual

- Created a new measure in Measures Table: Revenue per Customer = [Total Revenue]/[Total Customers]. Then added this to a card visual

2. **SUMMARY CHARTS** - Added a Donut Chart visual showing the total customers for each country.  
-  Used the Users[Country] column to filter the [Total Customers] measure.
- Add a Column Chart visual showing the number of customers who purchased each product category.     
- Used the Products[Category] column to filter the [Total Customers] measure.

3. **LINE CHART** - Added a Line Chart visual to the top of the page.  
- It shows [Total Customers] on the Y axis, and uses the Date Hierarchy we created previously for the X axis. Allow users to drill down to the month level and not any further.
*Added a trend line, and a forecast for the next 10 periods with a 95% confidence interval*

4. **TOP 20 CUSTOMER TABLE** - Created a new table which displays the top 20 customers filtered by revenue.  
- The table shows show each customer's full name, revenue, and number of orders.     
*Also added conditional formatting to the revenue column, to display data bars for the revenue values and coloured them to an appropriate transparency.*

5. **TOP CUSTOMER VISUAL CARDS** - Created 3 Customer visual cards.   
- Top Customer  
- Top Customers Revenue   
- Top Customers Order count   
These were all formatted by filtering out the top revenue from the name list and then applying the column needed to produce the correct result after.

6. **DATE SLICER** - Added a date slicer.  
- Used a between slicer style on the report page so are able to change years.


![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/2ba9ef9c-1e05-43e6-b084-869beb13e5ab)


## Creating Executive Summary Page   
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

![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/e0e785a6-de30-40f3-a980-3b32688f5d46)



## Creating Product Detail Page   
1. **GAUGE VISUALS**   
- Defined DAX measures for (Current Quarter: Orders,Revenue, Profit) and (Targets if 10% quarter on quarter growth for all three)
- Three gauge filters created with maximum value of gauge set to the Target measure.
- Conditional formatting applied for the callout value to change colour dependent on if target met. 

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

![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/500d7a65-d20f-4578-92fa-49fb0394462b)

![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/0d227b66-549c-4291-bf2b-ff30ed21a360)



## Creating Stores Map Page (and drillthrough pages)   
1. **MAP VISUALS**     
A map visual was added taking up most of the page real estate with room for a slicer to be placed in the forthcoming steps. Within the visuals setting the map controls were set to Auto-zoom:On,Zoom buttons:Off,Lasso button:Off. None of these settings needed to be changed.
- The Geography hierarchy was assigned to the Location and the PROFITYTD measure to the bubble size field.

2. **COUNTRY SLICER**   
A slicer waas added above the map set to Stores[Country] with a few of the settings changed e.g. Multi Select with Ctrl/Cmd and allowing for a select all option.

![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/260a9f53-6857-4d6c-a27b-4bbbf559af70)

4. **STORES DRILLTHROUGH PAGE**   
From the store map page it is useful to be able to check an individuals stor progress so a drillthrough page is able to provid a more detailed look at these. 
- A Stores Drillthrough page was made with page type set as drillthrough and a drillthrough when to 'used as category'. Then,set Drill through from to the country region.
- On the drill through pages many visuals as seen on other pages were added but specific to the store picked on the stores map page. 
- The visuals include: Top 5 product table, Total orders column chart, Gauges for Profit YTD compared to a 20% growth target and a card visual showing the selcted store.

![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/d4f595a4-cdcb-4707-ac05-df82e3ebc8ea)

4. **STORES TOOLTIPS PAGE**  
A separate page was created so when hovering over stores on the map page you are able to view the proift ytd gauge visual. The page was updated to the size of the visual and then on the map was set to the tooltip page.


![image](https://github.com/elliesgithub/data-analytics-power-bi-report762/assets/149676919/c290f262-e337-445d-a587-81e279f711bf)



## Cross-Filtering and Navigation   
At present there is some problems with cross-filtering regarding different visuals.This is fixed in the using the Edit interactions in the view section of Power BI.
1. **FIX CROSS FILTERING**      
Executive Summary Page- product category and top 10 Products were changed to not filter the card visuals or KPI's. The visuals were selcted and then the card visuals and KPI's were selected as none instead of cross-filter.   
Customer Detail Page- Top 20 customers set to not filter other visuals. The Donut Chart was set to not affect the line graph and the bar chart not to affecr the donut chart.   
Product Detail Page- The scatter graph and Top 10 products no longer affects any other visuals.

2. **FINISH NAVIGATION BAR**    
Buttons were added to the navigation bar to be able to travel to differnt pages using the navigation bar buttons. 
- 4 blank buttons were added and the custom icons already downloaded were used as a visual representation of each page. 
- The button style was set to on hover and action format as page navigation. Each of the buttons have a corresponding page e.g. world globe is the stores map.
- The icons were then copied across each page adapting the icon which links to it's own page each time.

At the end of the POWER BI tasks the Project should have 6 pages:

| Pages | Summaries|
|--     |--        |
| Customer Detail    |  Offers insights into customer information and trends.      |        
| Executive Summary   | Offers insights into targets and revenues of stores.         | 
| Product Detail    |Offers insights into products and particular categories acros different regions including a toolbar.          |   
| Stores Map    | Presents a map which has drilldown functioning to access information on different regions.         |   
| *Stores Drillthrough*    | This page is drillthroughed from the Stores Map page to offer further insight about stores.         |
| *Tooltip Page*    | This has the Profit YTD gauge which when hovered over areas of Stores Map page appears.         |              

## Creating Metrics for Users Outside the Company Using SQL

1. **CONNECT TO SQL SERVER**   
Using information given in the structure below connected to a SQL server from VScode. Have not provided the details out of privacy.
HOST: Given host   
PORT: Given port    
DATABASE: Given database    
USER: Given user  
PASSWORD: Given password  

2. **CHECK TABLE AND COLUMN NAMES**      
Using the 'POWERBI Projection.session.sql' document a list of the tables in the database was printed and the result saved to a csv file for reference under the SQL Table and Column Names folder.

A list of the columns in the orders table was printed and saved the result to a csv file called orders_columns.csv and was repeated for the the other tables which had useful columns. 

Any tables which did not have useful columns were not saved.

3. **QUERY THE DATABASE**  
The below questions were answered using SQL Querying:

   1.  How many staff are there in all of the UK stores?

   2. Which month in 2022 has had the highest revenue?

   3. Which German store type had the highest revenue for 2022?

   4. Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders

   5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

These are in the Querying Database Questions folder with both the SQL verion and csv version saved.

## File Structure 
README.md   
Power_BI_Report.pbix  
LICENSE.txt   
Querying Database Questions/  
 ┣ question_1.csv  
 ┣ question_1.sql  
 ┣ question_2.csv  
 ┣ question_2.sql  
 ┣ question_3.csv  
 ┣ question_3.sql  
 ┣ question_4.csv  
 ┣ question_4.sql  
 ┣ question_5.csv  
 ┗ question_5.sql  
SQL Table and Column Names/  
 ┣ country_region_columns.csv  
 ┣ database_columns_list.csv  
 ┣ dim_customer_columns.csv  
 ┣ dim_date_columns.csv   
 ┣ dim_product_columns.csv  
 ┣ dim_store_columns.csv  
 ┣ forquerying2_columns.csv  
 ┣ my_store_overviews_2_columns.csv  
 ┣ my_store_overviews_columns.csv  
 ┣ new_store_overview_columns.csv  
 ┣ orders_columns.csv  
 ┣ PowerBI Project.session.sql  
 ┗ test_store_overviews_columns.csv  

## License
MIT 

[Back to top](#top)
