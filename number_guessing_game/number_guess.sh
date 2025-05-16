#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# generate random number
NUMBER=$((1 + RANDOM % 1000))

# init count
COUNT=0

NUMBER_GUESS(){  
  if [[ $1 ]]
  then 
    echo -e "\n$1"
  fi

  # guess number
  read GUESS

  if [[ $GUESS =~ ^[0-9]+$ ]]
  then
    if [ "$GUESS" -gt "$NUMBER" ]
    then
      ((COUNT++))
      NUMBER_GUESS "It's lower than that, guess again:"
    elif [ "$GUESS" -lt "$NUMBER" ]
    then
      ((COUNT++))
      NUMBER_GUESS "It's higher than that, guess again:"
    else
      ((COUNT++))
      echo "You guessed it in $COUNT tries. The secret number was $NUMBER. Nice job!"
      GAME=$($PSQL "INSERT INTO games(player_id, secret_number, number_of_guess ) VALUES('$PLAYER_ID', $NUMBER, $COUNT)");
    fi
  else
    ((COUNT++))
    NUMBER_GUESS "That is not an integer, guess again:"
  fi
}

# get username
echo -e "\nEnter your username:"
read USERNAME
USER=$($PSQL "SELECT * FROM players WHERE player_name = '$USERNAME'");

# check if available
if [[ -z $USER ]]
then
  PLAYER=$($PSQL "INSERT INTO players(player_name) VALUES('$USERNAME')");
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE player_name = '$USERNAME'");
  NUMBER_GUESS "Guess the secret number between 1 and 1000:"
else
  PLAYER_ID=$($PSQL "SELECT player_id FROM players WHERE player_name = '$USERNAME'");
  GAMES_PLAYED=$($PSQL "SELECT COUNT(game_id) FROM games WHERE player_id = '$PLAYER_ID'");
  BEST_GAME=$($PSQL "SELECT MIN(number_of_guess) FROM games WHERE player_id = '$PLAYER_ID'");
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  NUMBER_GUESS "Guess the secret number between 1 and 1000:"
fi
