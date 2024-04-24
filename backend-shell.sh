#!/bin/bash 

echo -e "$G please enter the password $N"
read  mysql_root_password

source ./common-shell.sh 

check_root

dnf module disable nodejs -y &>>$LOGFILE
VALIDATION $? "disable nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATION $? "enable nodejs"

dnf install nodejs -y &>>$LOGFILE
VALIDATION $? "install nodejs"

id expense &>>$LOGFILE
if [ $? -ne 0 ]
then 
    echo -e "useradd expense" &>>$LOGFILE
else 
    echo -e "$Y user already added...SKIPPED $N"
fi 

mkdir -p /app


curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE

cd /app
rm *

unzip /tmp/backend.zip &>>$LOGFILE
VALIDATION $? "unzip backend"


cd /app

npm install &>>$LOGFILE
VALIDATION $? "install of npm"

cp /home/ec2-user/combind-/backend.service /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATION $? "copy of backend.service"

systemctl daemon-reload &>>$LOGFILE
VALIDATION $? "reload of backend.service"

systemctl start backend &>>$LOGFILE
VALIDATION $? "start backend"

systemctl enable backend &>>$LOGFILE
VALIDATION $? "enable backend"

dnf install mysql -y &>>$LOGFILE
VALIDATION $? "install mysql"

mysql -h db.daws78s.cloud -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATION $? "load data"

systemctl start backend &>>$LOGFILE
VALIDATION $? "start backend"