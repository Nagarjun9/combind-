#!/bin/bash 
set -e  # this one to use any below commend error will come its exist that place 
        # set -e not showing which line error come so we need use below trap commend to see which line error  

linenumber(){             
    echo "failed at $1: $2"
}

trap  'linenumber ${LINENO} "$BASH_COMMAND"' ERR  # this commend will show which line error 
#linenumber is function name we can chage it, but ${LINENO} "$BASH_COMMAND"' ERR we cont change  

USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo " you are not a super user please user root access"
else 
    echo " you are a superuser"
fi 

dnf install mysfaffql -y
dnf install git -y