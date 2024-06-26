#!/bin/bash

USERID=$(id -u)
TIMESTAME=$(date +%F-%H-%M-%S)
SCRITP_NAME=$(echo $0 |cut -d "." -f1)
LOGFILE=/tmp/$SCRITP_NAME-$TIMESTAME.log 

R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
N="\e[0m"

VALIDATION(){
    if [ $1 -ne 0 ]
    then 
       echo -e "$Y $2...failed $N"
       exit 1
    else 
       echo -e "$Y $2...success $N"
    fi 
}


check_root(){
       if [ $USERID -ne 0 ]
       then 
          echo -e " $R you are not a superuser please use root access $N"
          exit 1
       else 
          echo -e " $G you are a super user $N"
       fi 
}





