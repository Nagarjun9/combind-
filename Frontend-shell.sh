#!/bin/bash

source ./common-shell.sh 

check_root

dnf install nginx -y &>>$LOGFILE
VALIDATION $? "install of nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATION $? "enable nginx"

systemctl start nginx &>>$LOGFILE
VALIDATION $? "start nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
VALIDATION $? "remove files"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATION $? "download files"

cd /usr/share/nginx/html 


unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATION $? "unzip the file"

cp /home/ec2-user/combind-/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATION $? "copy the file"

systemctl restart nginx &>>$LOGFILE
VALIDATION $? "restart nginx"