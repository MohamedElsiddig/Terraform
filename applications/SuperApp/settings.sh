#!/bin/bash
aws s3 cp s3://${bucket_name}/war/ROOT.war /var/lib/${tomcat_version}/webapps/
hostnamectl set-hostname ${hostname}
HOSTNAME=`hostname`
echo "127.0.0.1 $HOSTNAME " >> /etc/hosts
AWS_INSTANCE_IP=`curl -s http://169.254.169.254/latest/meta-data/local-ipv4`
service tomcat8 restart
