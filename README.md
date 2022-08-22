# SQL Server JSON Performance Playground

_Background_:
The question arose to the impact of storing data as JSON in SQL server. This is a simple to attempt to checkout some common scenarios.

## Setup:
1. Create a SQL Server Database Named `Test`
2. Give permissions to a user and pass you have created
3. Run the script [create_table.sql](create_table.sql) in your preferred SQL Server IDE, or from sqlcmd
5. Make sure you have pyodbc package installed (in virtualenv if preferred) using `pip install pyodbc`
6. Set environment variables for username and password to connect to db (see comments near the top of [load.py](load.py)). Optional: set number of records in the variable `RECORD_COUNT`
7. run: `python load.py`

Now you can use the following scripts:
* [json_sample_queries.sql](json_sample_queries.sql) to explore how to query with json
* [average.sql](average.sql) to compare a column average with json column average
* [index_test.sql](index_test.sql) to compare filtering a record by a string with a column, vs a json value, including indexing the json value

You can email me with any questions or feedback at tim at hoolihan.net, or open a pull request with suggested changes.
