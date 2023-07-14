#!/bin/bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
sudo yum install jq -y
aws configure set region us-west-2
db_username=$(aws ssm get-parameter --name db_username --query 'Parameter.Value' --region us-west-2 --output text)
db_user_password=$(aws ssm get-parameter --name db_user_password --query 'Parameter.Value' --region us-west-2 --output text)
db_name=$(aws ssm get-parameter --name db_name --query 'Parameter.Value' --region us-west-2 --output text)
#db_host=`aws elbv2 describe-load-balancers --query 'LoadBalancers[*].DNSName' | jq -r 'to_entries[ ] | .value' | grep danish-default-NLB`
db_host="${db_dns}"
yum install amazon-linux-extras httpd -y
amazon-linux-extras install php7.2 -y
yum install httpd -y
systemctl start httpd
systemctl enable httpd
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf latest.tar.gz
cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/$db_name/g" wp-config.php
sed -i "s/username_here/$db_username/g" wp-config.php
sed -i "s/password_here/$db_user_password/g" wp-config.php
sed -i "s/localhost/$db_host/g" wp-config.php
#sed -i "s/wp_/wp_/g" wp-config.php
chmod -R 755 /var/www/html/*
chown -R apache:apache /var/www/html/*
#  enable .htaccess files in Apache config using sed command
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ s/AllowOverride None/AllowOverride all/' /etc/httpd/conf/httpd.conf
#Make apache to autostart and restart apache
systemctl enable  httpd.service
systemctl restart httpd.service
service httpd start