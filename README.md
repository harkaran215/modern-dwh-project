# mordern-dwh-project

Welcome to the Modern data warehosue project.
In this project I have create a data solution using mordern big data technology.

# Data Solution Architecture
This solution is based on the medallion architecture which consist of three layers bronzen, silver and gold.

- Bronze Layer: In this layer we get raw data from source in hdfs in a csv format.
- Silver Layer: In this layer data is read from bronze layer, standardize and processed as per the requerment. The data is then ingested into hive table in parquet format.
- Gold Layer: In this layer standardized data is moved from Silver layer into a data warehosue. This data now ready for any bussiness use case.

# Links or Tool used in the project
- Dataset: link for Dataset
- Apache Hadoop: used for storing data on hdfs
- Apache Hive: used for storing data on hive
- Apache Spark: used for processing big Data
- Postgresql: used to create Data warehosue
- DbDiagram: used to create Data Model
- Google Sildes: used to create Architecture diagram

# Project Overview
This project involves:

- Data Architecture: Designing a Modern Data Warehouse Using Medallion Architecture Bronze, Silver, and Gold layers.
- ETL Pipelines: Extracting, transforming, and loading data from source systems into the warehouse.
- Data Modeling: Developing fact and dimension tables optimized for analytical queries.
