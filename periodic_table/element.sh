#!/bin/bash

# PSQL Connection
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# Function to get element properties
ELEMENT_PROPERTIES() {
  # Check for number
  if [[ "$1" =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id WHERE elements.atomic_number='$1'");
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT" | while IFS="|" read ATOMIC_NO SYMBOL NAME ATOMIC_NO ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID TYPE_ID TYPE
      do
        echo "The element with atomic number $ATOMIC_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  # Check for letter
  elif [[ "$1" =~ ^[a-zA-Z]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT * FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id WHERE elements.symbol='$1' OR elements.name='$1'");
    if [[ -z $ELEMENT ]]
    then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT" | while IFS="|" read ATOMIC_NO SYMBOL NAME ATOMIC_NO ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID TYPE_ID TYPE
      do
        echo "The element with atomic number $ATOMIC_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      done
    fi
  fi
}

# Main Program
if [ -z "$1" ]
then
  echo "Please provide an element as an argument."
else
  ELEMENT_PROPERTIES $1
fi
