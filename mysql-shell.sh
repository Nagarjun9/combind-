#!/bin/bash

source ./common-shell.sh 

check_root

echo -e "$G please enter the password $N"
read -s mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
VALIDATION $? "installation of mysql"

systemctl enable mysqld &>>$LOGFILE
VALIDATION $? "enable of mysql"

systemctl start mysqld &>>$LOGFILE
VALIDATION $? "starting of mysql"


#Below code will be useful for idempotent nature
mysql -h db.daws78s.cloud -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
ROOTPASSWORD

