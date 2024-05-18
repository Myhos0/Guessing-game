#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username: "
read USERNAME

while [ -z $USERNAME ]
do
 echo "Please provide a username:"
 read USERNAME
done

USERNAME_ID=$($PSQL "SELECT user_id FROM users_info WHERE username='$USERNAME'")
 
if [[ -z $USERNAME_ID ]]
  then
    echo Welcome, $USERNAME! It looks like this is your first time here.
    GAMES_PLAYED=0
fi

echo "Guess the secret number between 1 and 1000:"
read NUMBER_USER

RANDOM_NUMBER=$(( (RANDOM % 1000) + 1 ))
ATTEMPS=0

is_integer() {
  [[ "$1" =~ ^-?[0-9]+$ ]]
}

while ! is_integer "$NUMBER_USER"
  do
    echo "That is not an integer, guess again:"
    read NUMBER_USER
  done

while [ $NUMBER_USER -ne $RANDOM_NUMBER ]
do
  if [ $NUMBER_USER -lt $RANDOM_NUMBER ]
  then
    echo "It's higher than that, guess again:"
  elif [ $NUMBER_USER -gt $RANDOM_NUMBER ]
  then
    echo "It's lower than that, guess again:"
  fi
  read NUMBER_USER

ATTEMPS=$((ATTEMPS + 1))

 while ! is_integer "$NUMBER_USER"
  do
    echo "That is not an integer, guess again:"
    read NUMBER_USER
  done

done

ATTEMPS=$((ATTEMPS + 1))
GAMES_PLAYED=$((GAMES_PLAYED + 1))

echo "You guessed it in $ATTEMPS tries. The secret number was $RANDOM_NUMBER. Nice job!"