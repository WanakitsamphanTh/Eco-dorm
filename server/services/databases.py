import sqlite3

conn = sqlite3.connect('ecodorm.db')
cursor = conn.cursor()

# Initialize student database
cursor.execute('CREATE TABLE IF NOT EXISTS scores (student_id INTEGER PRIMARY KEY, score INTEGER)')

# Initialize student database
cursor.execute('CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, email TEXT)')

# Initialize coupon database
cursor.execute('CREATE TABLE IF NOT EXISTS coupons (student_id INTEGER PRIMARY KEY, coupon_name TEXT, availability BOOL, expiry DATE)')

# Initialize recycle database
cursor.execute('CREATE TABLE IF NOT EXISTS recycling (student_id INTEGER PRIMARY KEY, timestaps DATE)')

#commit initialization
conn.commit()  # Save changes

#verify if databases exist
cursor.execute("SELECT * FROM students")
print(cursor.fetchall())
cursor.execute("SELECT * FROM coupons")
print(cursor.fetchall())
cursor.execute("SELECT * FROM recycling")
print(cursor.fetchall())
cursor.execute("SELECT * FROM scores")
print(cursor.fetchall())

# 6. Close the connection
conn.close()
