from flask import Flask, jsonify, request
import sqlite3
from flask_login import LoginManager, UserMixin, login_user, logout_user, login_required, current_user

app = Flask(__name__)
app.config['JSONIFY_PRETTYPRINT_REGULAR'] = True
app.secret_key = "ecodorm-secret-key"

DB_NAME = "ecodorm.db"

login_manager = LoginManager()
login_manager.init_app(app)


class User(UserMixin):
    def __init__(self, student_id):
        self.id = str(student_id)


def get_connection():
    conn = sqlite3.connect(DB_NAME)
    conn.row_factory = sqlite3.Row
    return conn


@login_manager.user_loader
def load_user(user_id):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM students WHERE id = ?", (user_id,))
    row = cursor.fetchone()
    conn.close()

    if row is None:
        return None

    return User(row["id"])


@login_manager.unauthorized_handler
def unauthorized():
    return jsonify({
        "message": "login required",
        "success": False
    }), 401


def check_same_user(student_id):
    if int(current_user.id) != student_id:
        return jsonify({
            "message": "forbidden",
            "success": False
        }), 403
    return None


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json(silent=True)

    if not data or "student_id" not in data:
        return jsonify({
            "message": "student_id is required",
            "success": False
        }), 400

    try:
        student_id = int(data["student_id"])
    except (TypeError, ValueError):
        return jsonify({
            "message": "student_id must be an integer",
            "success": False
        }), 400

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM students WHERE id = ?", (student_id,))
    row = cursor.fetchone()
    conn.close()

    if row is None:
        return jsonify({
            "message": "login failed",
            "success": False
        }), 404

    user = User(row["id"])
    login_user(user)

    return jsonify({
        "message": "login success",
        "success": True,
        "data": dict(row)
    }), 200


@app.route('/logout', methods=['POST'])
@login_required
def logout():
    logout_user()
    return jsonify({
        "message": "logout success",
        "success": True
    }), 200


@app.route('/me', methods=['GET'])
@login_required
def me():
    return jsonify({
        "message": "currently logged in",
        "success": True,
        "student_id": int(current_user.id)
    }), 200


@app.route('/students/<int:student_id>', methods=['GET'])
@login_required
def get_students_data(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM students WHERE id = ?", (student_id,))
    row = cursor.fetchone()
    conn.close()

    if row is None:
        return jsonify({"message": "student not found"}), 404

    return jsonify(dict(row)), 200


@app.route('/scores/<int:student_id>', methods=['GET'])
@login_required
def get_scores(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM scores WHERE student_id = ?", (student_id,))
    row = cursor.fetchone()
    conn.close()

    if row is None:
        return jsonify({"message": "score not found"}), 404

    return jsonify(dict(row)), 200


@app.route('/scores/<int:student_id>', methods=['PUT'])
@login_required
def put_scores(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    data = request.get_json(silent=True)

    if not data or "score" not in data:
        return jsonify({"message": "score is required"}), 400

    try:
        new_score = int(data["score"])
    except (TypeError, ValueError):
        return jsonify({"message": "score must be an integer"}), 400

    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM scores WHERE student_id = ?", (student_id,))
    row = cursor.fetchone()

    if row is None:
        cursor.execute(
            "INSERT INTO scores (student_id, score) VALUES (?, ?)",
            (student_id, new_score)
        )
    else:
        cursor.execute(
            "UPDATE scores SET score = ? WHERE student_id = ?",
            (new_score, student_id)
        )

    conn.commit()
    cursor.execute("SELECT * FROM scores WHERE student_id = ?", (student_id,))
    updated_row = cursor.fetchone()
    conn.close()

    return jsonify({
        "message": "score updated",
        "data": dict(updated_row)
    }), 200


@app.route('/recycle/<int:student_id>', methods=['GET'])
@login_required
def get_recycle(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM recycling WHERE student_id = ?", (student_id,))
    rows = [dict(row) for row in cursor.fetchall()]
    conn.close()

    return jsonify(rows), 200


@app.route('/recycle/<int:student_id>', methods=['POST'])
@login_required
def post_recycle(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    data = request.get_json(silent=True)

    if not data or "timestamp" not in data:
        return jsonify({"message": "timestamp is required"}), 400

    new_timestamp = data["timestamp"]

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO recycling (student_id, timestamp) VALUES (?, ?)",
        (student_id, new_timestamp)
    )
    conn.commit()

    cursor.execute(
        "SELECT * FROM recycling WHERE student_id = ? ORDER BY timestamp DESC LIMIT 1",
        (student_id,)
    )
    new_row = cursor.fetchone()
    conn.close()

    return jsonify({
        "message": "recycle data added",
        "data": dict(new_row)
    }), 201


@app.route('/coupons/<int:student_id>', methods=['GET'])
@login_required
def get_coupons(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM coupons WHERE student_id = ?", (student_id,))
    row = cursor.fetchone()
    conn.close()

    if row is None:
        return jsonify({"message": "coupon not found"}), 404

    return jsonify(dict(row)), 200


@app.route('/coupons/<int:student_id>', methods=['DELETE'])
@login_required
def delete_coupons(student_id):
    denied = check_same_user(student_id)
    if denied:
        return denied

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM coupons WHERE student_id = ?", (student_id,))
    row = cursor.fetchone()

    if row is None:
        conn.close()
        return jsonify({"message": "coupon not found"}), 404

    deleted_data = dict(row)
    cursor.execute("DELETE FROM coupons WHERE student_id = ?", (student_id,))
    conn.commit()
    conn.close()

    return jsonify({
        "message": "coupon deleted",
        "data": deleted_data
    }), 200


@app.route('/ranking', methods=['GET'])
def ranking():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT RANK() OVER (ORDER BY scores.score DESC) AS rank, students.name
        FROM students
        JOIN scores ON students.id = scores.student_id
    """)
    rows = [dict(row) for row in cursor.fetchall()]
    conn.close()

    return jsonify(rows), 200


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)