import boto3
import csv

s3_client = boto3.client('s3')

def extract_data_lines(file_path):
    pattern = "INSERT INTO \"PUBLIC\".\"GAMES\""
    pattern_len = len(pattern + " VALUES)")
    
    # Open the file in read mode
    with open(file_path, 'r') as file:
        # Initialize an empty list to store interesting lines
        data_lines = []
        
        # Iterate over each line in the file
        for line in file:
            # Check if the line starts with "Interesting"
            if line.startswith(pattern):
                cleared_data_line = line.strip()[pattern_len:-2].replace('\'', '').replace(' UUID', '').replace(' TIMESTAMP', '').split(', ')
               
                data_lines.append(cleared_data_line)
    
    # Return the list of interesting lines
    return data_lines


def write_to_csv(data, file_name):
    with open(file_name, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['ID', 'UUID', 'TIME'])
        writer.writerows(data)


def lambda_handler(event, context):
    file_path = './mkeloData.sql'
    interesting_lines = extract_data_lines(file_path)
    
    write_to_csv(interesting_lines, '/tmp/cleaned_data.csv')
    
    s3_client.upload_file('/tmp/cleaned_data.csv', "mkelo-data-analysis2", 'cleaned_data.csv')
    
    return interesting_lines[:10]
