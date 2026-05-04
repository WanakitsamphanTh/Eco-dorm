import databases as db
from flask import Flask, jsonify, request
import json, random, os, threading

# Thread safety
app = Flask(__name__)
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True

# get students_id info
@app.route('/students/<int:id>', methods = ['GET'])
def get_students_data(id):
    pass

# get scores info
@app.route('/scores', methods = ['GET'])
def get_scores(student_id):
    pass

# update scores info
@app.route('/scores<int:student_id>', methods = ['UPDATE'])
def update_scores(student_id):
    pass

# get recycle info
@app.route('/recycle/<int:student_id>', methods = ['GET'])
def get_recycle(student_id):
    pass

# get recycle info
@app.route('/recycle/<int:student_id>', methods = ['UPDATE'])
def update_recycle(student_id):
    pass

# get copons info
@app.route('/coupons/<int:student_id>', methods = ['GET'])
def get_copons(student_id):
    pass

# delete copons info
@app.route('/coupons/<int:student_id>', methods = ['DELETE'])
def delete_copons(student_id):
    pass



if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)

    