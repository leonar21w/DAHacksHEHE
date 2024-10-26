import csv
import json
from datetime import datetime

# Function to read CSV and convert to list of dictionaries with decoded phases
def csv_to_phase_data(file_path):
    with open(file_path, mode='r') as file:
        csv_reader = csv.DictReader(file)
        phase_data = []
        
        # Decode the moon phase for each row
        for row in csv_reader:
            row['moon_phase_name'] = decode_moon_phase(float(row['moon_phase']))
            phase_data.append(row)
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

# Convert CSV file to a list of dictionaries with decoded phases
moon_phase_data = csv_to_phase_data(moon_phase_csv)

# Create a dictionary with the updated moon phase data
combined_phase_data = {
    "updated_at": datetime.now().isoformat(),
    "moon_phase": moon_phase_data
}

# Save updated moon phase data to a JSON file
with open('decoded_moon_phase_data.json', 'w') as file:
    json.dump(combined_phase_data, file, indent=4)

print("Decoded moon phase data has been saved to decoded_moon_phase_data.json")
