from flask import Flask, jsonify
import json
import requests
import csv
from datetime import datetime

app = Flask(__name__)

# Function to read CSV and convert to dictionary with dates as keys and decoded moon phases as values
def csv_to_phase_data(file_path):
    with open(file_path, mode='r') as file:
        csv_reader = csv.DictReader(file)
        phase_data = {}
        
        # Decode the moon phase for each row and use date as the key
        for row in csv_reader:
            date = row['validdate']
            phase_value = float(row['moon_phase'])
            phase_data[date] = decode_moon_phase(phase_value)
        return phase_data

# Function to decode moon phase based on phase value
def decode_moon_phase(phase):
    if phase == 0:
        return "New Moon"
    elif 0 < phase < 0.25:
        return "Waxing Crescent"
    elif phase == 0.25:
        return "First Quarter"
    elif 0.25 < phase < 0.5:
        return "Waxing Gibbous"
    elif phase == 0.5:
        return "Full Moon"
    elif 0.5 < phase < 0.75:
        return "Waning Gibbous"
    elif phase == 0.75:
        return "Last Quarter"
    elif phase > 0.75 or phase < -0.75:
        return "Full Moon"
    elif -0.25 < phase < 0:
        return "Waning Crescent"
    elif phase == -0.25:
        return "Last Quarter"
    elif -0.5 < phase < -0.25:
        return "Waning Gibbous"
    return "Transition"

# Path to the moon phase CSV file
moon_phase_csv = 'moon_phase_data.csv'

# Convert CSV file to dictionary with decoded moon phases
moon_phase_data = {
    "last_updated": datetime.now().isoformat(),
    "phases": csv_to_phase_data(moon_phase_csv)
}

# Save updated moon phase data to a JSON file
with open('decoded_moon_phase_data.json', 'w') as file:
    json.dump(moon_phase_data, file, indent=4)

print("Decoded moon phase data has been saved to decoded_moon_phase_data.json")

# Flask route to serve moon phase data
@app.route('/moon_data', methods=['GET'])
def get_moon_data():
    with open('decoded_moon_phase_data.json') as f:
        moon_data = json.load(f)
    return jsonify(moon_data)

# Function to fetch latest Mars weather data from NASA API
def fetch_mars_weather():
    api_key = 'tz2156eF3UPR716dalaIIaPAy4KcuuMcNekGRQEE'  # Replace with your NASA API key
    url = f'https://api.nasa.gov/insight_weather/?api_key={api_key}&feedtype=json&ver=1.0'
    
    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        sols = data['sol_keys']
        latest_sol = sols[-1]  # Get the latest sol (Martian day)
        latest_weather = data[latest_sol]
        
        # Construct the dictionary for Mars data with last updated timestamp
        mars_data = {
            "last_updated": datetime.now().isoformat(),
            "sol": int(latest_sol),
            "temperature": {
                "average": latest_weather['AT']['av'],
                "min": latest_weather['AT']['mn'],
                "max": latest_weather['AT']['mx']
            }
        }

        # Save the dictionary directly to the JSON file
        with open('mars_weather.json', 'w') as file:
            json.dump(mars_data, file, indent=4)
        
        print("Mars data updated successfully!")
    else:
        print("Failed to retrieve Mars data:", response.status_code)

# Run the function to fetch Mars data
fetch_mars_weather()

# Flask route to serve mars data
@app.route('/mars_data', methods=['GET'])
def get_mars_data():
    with open('mars_weather.json') as f:
        mars_data = json.load(f)
    return jsonify(mars_data)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0', port=8000)
