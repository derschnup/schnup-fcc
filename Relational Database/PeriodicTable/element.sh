#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

FIND_ELEMENT() {
  # if no argument provided
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
    return
  fi

  # if argument is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_PROPERTIES=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties JOIN elements USING (atomic_number) JOIN types USING (type_id)
    WHERE atomic_number=$1;")
 
  # try symbol and name
  elif [[ ! -z $1 ]]
  then
    SYMBOL_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties JOIN elements USING (atomic_number) JOIN types USING (type_id)
    WHERE symbol='$1';")
    NAME_RESULT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties JOIN elements USING (atomic_number) JOIN types USING (type_id)
    WHERE name='$1';")
    
    if [[ ! -z $SYMBOL_RESULT ]]
    then
      ELEMENT_PROPERTIES=$SYMBOL_RESULT
    elif [[ ! -z $NAME_RESULT ]]
    then
      ELEMENT_PROPERTIES=$NAME_RESULT
    fi
   fi 

  if [[ ! -z $ELEMENT_PROPERTIES ]]
  then
    echo "$ELEMENT_PROPERTIES" | while read ATOMIC_NO BAR NAME BAR SYMBOL BAR TYPE BAR ATOMIC_MASS BAR MELTING BAR BOILING
    do
      echo "The element with atomic number $ATOMIC_NO is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done

  else
    echo "I could not find that element in the database."
  fi
}

FIND_ELEMENT $1

#finally done