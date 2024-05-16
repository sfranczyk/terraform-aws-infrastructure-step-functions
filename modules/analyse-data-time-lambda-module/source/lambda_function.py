from datetime import datetime

def lambda_handler(event, context):
    valid_games = []
    
    for game in event['Items']:
        string_data = game['TIME']
        data = datetime.strptime(string_data, "%Y-%m-%d %H:%M:%S.%f")
        
        if not 5 < data.hour < 20:
            valid_games.append({"time": game["TIME"], "uuid": game["UUID"]})

    return valid_games
