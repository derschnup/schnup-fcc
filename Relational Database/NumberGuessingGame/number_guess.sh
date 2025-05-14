#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"
#=$($PSQL "")

# ask for username, check if in database

GET_USERNAME() {
  echo "Enter your username: "
  read USERNAME
  if [[ ${#USERNAME} -gt 22 ]]
  then
    echo -e "Username is too long. Max. 22 chars.\n"
    GET_USERNAME
  fi
  # check if username exists via user_id; say welcome
  USERID_RESULT=$($PSQL "SELECT user_id, games_played, best_game FROM userinfo WHERE username='$USERNAME'")
  #echo "testecho 4: $USERID_RESULT"
  if [[ -z $USERID_RESULT ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    INSERT_USER=$($PSQL "INSERT INTO userinfo (username) VALUES ('$USERNAME');")
  fi
  if [[ ! -z $USERID_RESULT ]]
  then
    echo $USERID_RESULT | while read USER_ID BAR GAMES_PLAYED BAR BEST_GAME
    do
      echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
    done
  fi
  # init random number and counter, then call guessing function
  RANDINT=$(( RANDOM % 1000 + 1 ))
  echo "Testecho 1. Random no.: $RANDINT"
  COUNTER=1
  echo "Guess the secret number between 1 and 1000:"
  GUESS_GAME
}

GUESS_GAME() {
  read GUESS
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
    (( COUNTER += 1 ))
    GUESS_GAME
  elif [[ $GUESS -gt $RANDINT ]]
  then
    echo "It's lower than that, guess again:"
    (( COUNTER += 1 ))
    GUESS_GAME
  elif [[ $GUESS -lt $RANDINT ]]
  then
    echo "It's higher than that, guess again:"
    (( COUNTER += 1 ))
    GUESS_GAME
  elif [[ $GUESS -eq $RANDINT ]]
  then
    UPDATE_STATS
    echo "You guessed it in $COUNTER tries. The secret number was $RANDINT. Nice job!"
    exit
  fi
}

UPDATE_STATS() {
  # add counter and no. of games to database
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM userinfo WHERE username = '$USERNAME'")
  (( GAMES_PLAYED ++ ))
  PLAYED_UPDATE_RESULT=$($PSQL "UPDATE userinfo SET games_played = $GAMES_PLAYED WHERE username = '$USERNAME'")
  
  GET_BEST_GAME=$($PSQL "SELECT best_game FROM userinfo WHERE username = '$USERNAME'")
  GET_BEST_GAME=$(echo "$GET_BEST_GAME" | xargs)
  #echo "Testecho 2: best_game: $GET_BEST_GAME"

  if [[ $COUNTER -lt $GET_BEST_GAME || -z $GET_BEST_GAME ]]
  then
    BEST_UPDATE_RESULT=$($PSQL "UPDATE userinfo SET best_game = $COUNTER WHERE username = '$USERNAME'")
    #echo "Testecho 3: updateresult: $GET_BEST_GAME, $BEST_UPDATE_RESULT"
  fi
}

GET_USERNAME