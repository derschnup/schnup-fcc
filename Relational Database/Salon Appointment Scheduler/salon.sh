#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {
  # print error message on incorrect user input
  if [[ ! -z $1 ]]
  then
    echo -e "\n$1"
  fi
  echo -e "\n~~ Salon Service Menu ~~"
  echo -e "\nPlease select a service: \n"
  LIST_OF_SERVICES=$($PSQL "SELECT service_id, name FROM services")
  # display numbered list of services
  echo "$LIST_OF_SERVICES" | while read SERV_ID BAR SERVICE
  do
    echo -e "$SERV_ID) $SERVICE"
  done
  
  # get user input and check if service exists
  read SERVICE_ID_SELECTED
  # if input is not number
  SERVICE_ID=$($PSQL "SELECT service_id from services WHERE service_id=$SERVICE_ID_SELECTED")
  if [[ -z $SERVICE_ID ]]
  then
  MAIN_MENU 'Please enter a valid option.' 
   
  else
    CUSTOMER_INFO
  fi

}

CUSTOMER_INFO() {
  if [[ ! -z $1 ]]
  then
    echo -e "$1"
  fi
  echo -e "\nPlease enter your phone number: "
  read CUSTOMER_PHONE
  if [[ -z $CUSTOMER_PHONE ]]
  then
    CUSTOMER_INFO "\nYou must enter a phone number.\n"
  fi
  CUSTOMER_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_RESULT ]]
  then
    echo -e "Please enter your name: "
    read CUSTOMER_NAME
    CUSTOMER_ADD=$($PSQL "INSERT INTO customers (phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
  fi
  
  APPOINTMENTS
}

APPOINTMENTS() {
  echo -e "\nPlease enter the time for your appointment: "
  read SERVICE_TIME
  CUSTOMER_RESULT=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE customer_id='$CUSTOMER_RESULT'")
  SERVICE_SELECTED=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")
  APPOINTMENT_ADD=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_RESULT, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $SERVICE_SELECTED at $SERVICE_TIME, $CUSTOMER_NAME." | sed 's/  / /g'
}
MAIN_MENU