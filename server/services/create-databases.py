import sqlite3

conn = sqlite3.connect('ecodorm.db')
cursor = conn.cursor()

# Initialize student database
cursor.execute('CREATE TABLE IF NOT EXISTS scores (student_id INTEGER PRIMARY KEY, score INTEGER)')
score_data = [
    (1001, 140),
    (1002, 120),
    (1003, 95),
    (1004, 110),
    (1005, 70)
]
cursor.executemany('INSERT OR IGNORE INTO scores (student_id, score) VALUES (?, ?)',score_data)

# Initialize student database
cursor.execute('CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, email TEXT)')
student_data = [
    (1001, "Thanapat", "thanapat@sendai.com"),
    (1002, "Credit", "credit@sendai.com"),
    (1003,"Kenza","kenza@sendai.com"),
    (1004,"Renzo","renzo@sendai.com"),
    (1005,"Nour","nour@roubaix.com")
]
cursor.executemany('INSERT OR IGNORE INTO students (id, name, email) VALUES (?, ?, ?)',student_data)

# Initialize coupon database
cursor.execute('CREATE TABLE IF NOT EXISTS coupons (student_id INTEGER PRIMARY KEY, coupon_name TEXT, availability BOOL, expiry DATE)')
coupon_data = [
    (1001, "Free Drink", 1, "2026-12-31"),
    (1002, "Snack Discount", 1, "2026-10-15"),
    (1003, "Laundry Coupon", 0, "2026-09-01"),
    (1004, "Free Coffee", 1, "2026-11-20"),
    (1005, "10% Off Cafeteria", 1, "2026-08-30")
]
cursor.executemany('INSERT OR IGNORE INTO coupons (student_id, coupon_name, availability, expiry) VALUES (?, ?, ?, ?)',coupon_data)

# Initialize recycle database
cursor.execute('CREATE TABLE IF NOT EXISTS recycling (student_id INTEGER PRIMARY KEY, timestamp DATE)')
recycle_data = [
    (1001, "2026-05-05 10:30:00"),
    (1002, "2026-05-06 14:15:00"),
    (1003, "2026-05-05 09:00:00"),
    (1004, "2026-05-07 16:45:00"),
    (1005, "2026-05-06 14:20:00")
]
cursor.executemany('INSERT OR IGNORE INTO recycling (student_id, timestamp) VALUES (?, ?)',recycle_data)

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
