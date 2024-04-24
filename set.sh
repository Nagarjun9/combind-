#!/bin/bash 
set -e

trap  'linenumber ${LINENO} "$BASH_COMMAND"' ERR 

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo " you are not a super user please user root access"
else 
    echo " you are a superuser"
fi 

dnf install mysfaffql -y
dnf install git -y