#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#echo $($PSQL "")
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINGOALS OPPGOALS
do
# Add unique teams to table. Both winners and opponents
echo $YEAR $ROUND $WINNER $OPPONENT $WINGOALS $OPPGOALS
  if [[ $YEAR != 'year' ]]
  then
    TEAM_ID_WINNER=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    TEAM_ID_OPPONENT=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    echo Team IDs from query for winner - $TEAM_ID_WINNER opponent - $TEAM_ID_OPPONENT
    # If team_id is not found, add to table
    if [[ -z $TEAM_ID_WINNER ]]
    then
      INSERT_TEAM_ID_WINNER=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
      echo Inserted winner team ID: $INSERT_TEAM_ID_WINNER
    fi
    if [[ -z $TEAM_ID_OPPONENT ]]
    then
      INSERT_TEAM_ID_OPPONENT=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
      echo Insert opponent team ID: $INSERT_TEAM_ID_OPPONENT
    fi
  
  # Add rows to games table:
  
  GET_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
  GET_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  
  INSERT_ROW=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $GET_WINNER_ID, $GET_OPPONENT_ID, $WINGOALS, $OPPGOALS)")
  
  fi
done