# Clinic DB Project

This project contains a set of SQL scripts developed using MS SQL for managing a clinic database. The scripts are designed to create the necessary database structure, populate it with initial data, and provide various querying capabilities.

## Files

- **clinic.png**: ERD diagram of database that was contructed ahead of implementation of database. It is worth to inspect it ahead of executing sql scripts to get good understanding of the project.

- **create.sql**: This script is used to create the database schema, including tables, views, and other necessary database objects.

- **delete-update.sql**: This script was created in order to learn how to use cascade updating and deletion.

- **drop.sql**: The script in this file is used to drop the entire clinic database, including all tables and associated objects. It is used when there is a need to completely remove the database.

- **insert.sql**: This script includes SQL statements for inserting initial data into the clinic database. It may include inserting sample patient records, doctor information, etc.

- **queries.sql**: This script contains various SQL queries that can be executed to retrieve specific information from the clinic database. These queries may include retrieving patient details, generating reports, statistical analysis, and more.

## Usage

To use the Clinic DB scripts, follow these steps:

1. Ensure that you have MS SQL Server installed and running.

2. Execute the `create.sql` script to create the necessary database schema and objects.

3. Execute the `insert.sql` script to populate the database with initial data if required.

4. Execute the `queries.sql` script to run predefined queries and retrieve specific information from the database.

5. If you want you can play with `delete-update.sql` script to check how cascade updates and deletions works.

6. Use the `drop.sql` script only when you want to completely remove the clinic database.
