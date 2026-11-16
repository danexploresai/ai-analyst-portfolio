# 00_load_csv_to_sqlite.py
# Loads the PaySim CSV into a SQLite database so the numbered .sql files
# in this folder can be run against it. Nothing is cleaned or changed:
# every row and every value is loaded as it is in the file.
#
# How to run (from the project folder):
#   python sql/00_load_csv_to_sqlite.py data/PS_20174392719_1491204439457_log.csv paysim.db

import csv
import sqlite3
import sys

# The CSV path and the database path come from the command line.
csv_path = sys.argv[1]
db_path = sys.argv[2]

# Open (or create) the database file.
con = sqlite3.connect(db_path)

# Create an empty table with the same 11 columns as the CSV, in the same
# order. Column names are kept exactly as they are in the file.
con.execute("DROP TABLE IF EXISTS transactions")
con.execute("""
    CREATE TABLE transactions (
        step            INTEGER,
        type            TEXT,
        amount          REAL,
        nameOrig        TEXT,
        oldbalanceOrg   REAL,
        newbalanceOrig  REAL,
        nameDest        TEXT,
        oldbalanceDest  REAL,
        newbalanceDest  REAL,
        isFraud         INTEGER,
        isFlaggedFraud  INTEGER
    )
""")

# Read the CSV and insert the rows.
with open(csv_path, newline="") as f:
    reader = csv.reader(f)

    # The first line is the header. Print it so we can see the column names.
    header = next(reader)
    print("Header:", header)

    # Insert every remaining line. SQLite stores a value as a number when
    # it looks like one, and as text when it does not, so a bad value in
    # a number column would show up later as type 'text' in the profile.
    con.executemany(
        "INSERT INTO transactions VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        reader,
    )

# Save the inserts to disk.
con.commit()

# Check: the table should have one row per CSV line, minus the header.
rows = con.execute("SELECT COUNT(*) FROM transactions").fetchone()[0]
print("Rows loaded:", rows)

con.close()
