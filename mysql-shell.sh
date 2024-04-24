#!/bin/bash

source ./common-shell.sh 
check_root

echo "please enter the password"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATION $? "installation of mysql"

systemctl enable mysqld &>>$LOGFILE
VALIDATION $? "enable of mysql"

systemctl start mysqld &>>$LOGFILE
VALIDATION $? "starting of mysql"


#Below code will be useful for idempotent nature
mysql -h db.daws78s.cloud -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
if [ $? -ne 0 ]
then 
    mysql_secure_installation --set-root-pass ${mysql_root_password}
else 
   echo " mysql root password already set...SKIPPED"
fi 

