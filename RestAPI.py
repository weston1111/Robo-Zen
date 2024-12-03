from flask import Flask, request, jsonify
import json
from waitress import serve  # Production WSGI server

app = Flask(__name__)

# Store some data (replace with database if needed)
data_store = {}

@app.route('/api/data', methods=['GET'])
def get_data():
    """Endpoint to retrieve data"""
    return jsonify(data_store)

@app.route('/api/data', methods=['POST'])
def post_data():
    """Endpoint to receive data from iOS app"""
    try:
        content = request.json
        # Store the received data
        data_store.update(content)
        return jsonify({"status": "success", "message": "Data received"}), 200
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 400

@app.route('/api/data/<key>', methods=['GET'])
def get_specific_data(key):
    """Endpoint to get specific data by key"""
    if key in data_store:
        return jsonify({key: data_store[key]})
    return jsonify({"error": "Key not found"}), 404

if __name__ == '__main__':
    # Run the server on all available network interfaces
    # Use waitress for production deployment
    serve(app, host='0.0.0.0', port=8080)
