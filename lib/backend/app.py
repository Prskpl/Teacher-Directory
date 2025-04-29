from flask import Flask, jsonify
from flask_cors import CORS
from pymongo import MongoClient
import os

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# MongoDB configuration
MONGO_URI = os.getenv('MONGO_URI', 'mongodb://localhost:27017/')
client = MongoClient(MONGO_URI)
db = client['teacher_directory']
teachers_collection = db['teachers']

@app.route('/teachers', methods=['GET'])
def get_teachers():
    teachers = list(teachers_collection.find({}, {'_id': 0}))
    return jsonify(teachers)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
