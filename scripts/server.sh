# #!/bin/bash
# sudo yum install -y amazon-linux-extras
# sudo yum update -y
# sudo amazon-linux-extras enable php8.0 -y
# sudo yum clean metadata -y
# sudo yum install php-cli php-pdo php-fpm php-mysqlnd -y

#!/bin/bash
yum update -y
yum install -y httpd.x86_64
systemctl start httpd.service
systemctl enable httpd.service
echo “Hello World from $(hostname -f)” > /var/www/html/index.html