import random
import json 
import pyodbc
from pprint import pprint
import os

# db info
SERVER = "localhost"
DB = "Test"
USERNAME = "ymmit"
PASSWORD = os.environ.get("SSPASS") # set on command line for session
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+SERVER+';DATABASE='+DB+';UID='+USERNAME+';PWD='+ PASSWORD)
cursor = cnxn.cursor()

# record info
RECORD_COUNT = 1000000
RESULTS = ["hit", "walk", "out", "strikeout"]
records = []

# Truncate Table
print("Truncating table...")
tsql = "TRUNCATE TABLE Loading.baseball_json;"
with cursor.execute(tsql):    
    pass

# Create Records
for n in range(RECORD_COUNT):
    obj = {
        "id": n,
        "result": random.choice(RESULTS),
        "temperature": random.uniform(20, 110)
    }
    records.append(obj)
print("count of records mocked: {}".format(len(records)))

# Insert records
print("Inserting records...")
tsql = "INSERT INTO Loading.baseball_json(result, temperature, raw_json) values (?,?,?);"
for row in records:
    with cursor.execute(tsql, row["result"], row["temperature"], json.dumps(row)):
        n = row["id"] + 1
        if n % 100000 == 0:
            print("inserted {} record(s)".format(n))

# Confirm inserts
print("Reading record count")
tsql = "SELECT COUNT(1) FROM Loading.baseball_json"
with cursor.execute(tsql):
    row = cursor.fetchone()
    while row:
        pprint(row)
        row = cursor.fetchone()