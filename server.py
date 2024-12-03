from flask import Flask, request, jsonify
import json
from waitress import serve # Production WSGI server
from motorCoordination import declareMotors, executeDesign

motForearm, motBicep = declareMotors()
app = Flask(__name__)

# Store some data (replace with database if needed)
data_store = {}
@app.route('/api/data', methods=['GET'])

def get_data():
    # Endpoint to retrieve data
    return jsonify(data_store)
    
@app.route('/api/data', methods=['POST'])
def post_data():
    # Endpoint to receive data from iOS
    try:
        content = request.json
        # Store retrieved data
        data_store.update(content)
        #print(data_store)
        print("Success")
        #print(data_store["points"])
        executeDesign(motForearm, motBicep, data_store["points"])
        return jsonify({"status":"success", "message":"Data received"}), 200
    except Exception as e:
    	return jsonify({"status":"error", "message":str(e)}), 400
    	
    	
if __name__ == '__main__':
    serve(app, host='0.0.0.0', port=8080)
