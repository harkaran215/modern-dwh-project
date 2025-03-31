# Modern Data Warehouse Project

Welcome to the Modern Data Warehouse project.

This Project implements a data solution architecture using big data technology to build a business ready data warehouse which can be used for business use cases.
___
# Data Solution Architecture

This solution is based on the medallion architecture which consist of three layers bronzen, silver and gold.

![Alt text](https://github.com/harkaran215/mordern-dwh-project/blob/main/docs/Data-architecture.PNG)

- Bronze Layer: In this layer we get raw data from source in hdfs in a csv format.
- Silver Layer: In this layer data is read from bronze layer, standardize and processed as per the requerment. The data is then ingested into hive table in parquet format.
- Gold Layer: In this layer standardized data is moved from Silver layer into a data warehosue. This data now ready for any bussiness use case.
___
# Links or Tool used in the project
- Dataset: link for Dataset
- Apache Hadoop: used for storing data on hdfs
- Apache Hive: used for storing data on hive
- Apache Spark: used for processing big Data
- Postgresql: used to create Data warehosue
- DbDiagram: used to create Data Model
- Google Sildes: used to create Architecture diagram
___
# Project Overview
This project involves:

- Data Architecture: Designing a Modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold layers.
- ETL Pipelines: Extracting, transforming, and loading data from source systems into the warehouse.
- Data Modeling: Developing fact and dimension tables optimized for analytical queries.
___
# Building the Data Warehouse
Objective

Develop a modern data warehouse using big data technology to consolidate fashion sales data, enabling analytical reporting and informed decision-making.

Specifications
- Data Sources: Import data CSV files.
- Data Quality: Cleanse and resolve data quality issues prior to analysis.
- Integration: Create a Data warehouse based on star schema, analytical queries.
- Scope: Focus on the latest dataset only; historization of data is not required.
- Documentation: Provide clear documentation of the data model to support both business stakeholders and analytics teams.
___
# License
This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.
