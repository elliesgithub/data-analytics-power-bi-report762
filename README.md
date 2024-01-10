# Data Analytics Power BI Report

This is a project for AiCore which involves a number of different tasks using PowerBI.

Project objective: 
> You have recently been approached by a medium-sized international retailer who is keen on elevating their business intelligence practices. With operations spanning across different regions, **they've accumulated large amounts of sales from disparate sources over the years**.
Recognizing the value of this data, they aim to transform it into actionable insights for better decision-making. Your goal is to ****use Microsoft Power BI to design a comprehensive Quarterly report. This will involve extracting and transforming data from various origins, designing a robust data model rooted in a star-based schema, and then constructing a multi-page report.**
The report will present a high-level business summary tailored for C-suite executives, and also give insights into their highest value customers segmented by sales region, provide a detailed analysis of top-performing products categorised by type against their sales targets, and a visually appealing map visual that spotlights the performance metrics of their retail outlets across different territories."



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