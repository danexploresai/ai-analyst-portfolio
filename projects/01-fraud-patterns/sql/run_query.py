# run_query.py
# Runs one .sql file against the SQLite database and prints the result.
#
# How to run (from the project folder):
#   python sql/run_query.py paysim.db sql/01_shape.sql

import sqlite3
import sys

# The database path and the SQL file path come from the command line.
db_path = sys.argv[1]
sql_path = sys.argv[2]

# Read the query text from the file.
with open(sql_path) as f:
    query = f.read()

# Open the database read-only, so a query can never change the data.
con = sqlite3.connect("file:" + db_path + "?mode=ro", uri=True)
cursor = con.execute(query)

# Print the column names, then one line per result row.
print(" ; ".join(col[0] for col in cursor.description))
for row in cursor:
    print(" ; ".join(str(value) for value in row))

con.close()
