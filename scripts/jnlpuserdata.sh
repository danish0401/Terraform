#!/bin/bash
sudo yum update -y
sudo yum install wget
sudo amazon-linux-extras install java-openjdk11
sudo amazon-linux-extras install epel -y
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo service jenkins start
sudo yum install git -y
sleep 1
jenkins_token=117cd6215e015486469ac4bab3982dfe21
jenkins_username=Danish
jenkins_url=http://35.167.155.37:8080/
random_num=`ip address | grep global | cut -d" " -f6 | cut -d"/" -f1 | sed 's/\.//g'`
cmd="java -jar jenkins-cli.jar -s ${jenkins_url} -auth ${jenkins_username}:${jenkins_token}"
#aws s3 sync s3://danish-jenkins-jars .
sed -i "s/node_number/${random_num}/g" config.xml
cat config.xml | $cmd create-node "jnlpnode${random_num}"
secret=`curl --user "${jenkins_username}:${jenkins_token}" ${jenkins_url}/manage/computer/jnlpnode${random_num}/slave-agent.jnlp | sed -e 's/<[^>]*.//g' | cut -c 1-64`
nohup java -jar agent.jar -jnlpUrl ${jenkins_url}/manage/computer/jnlpnode${random_num}/jenkins-agent.jnlp -secret ${secret} -workDir "/home/ec2-user" &
# create systemd file for slave demon
touch /etc/systemd/system/jenkins-agent.service
var="your text"
echo "simply put, just so: $var" > a.config

echo " [Unit]
Description=Jenkins Slave
Wants=network.target
After=network.target

[Service]
ExecStart=java -jar ${NODE_HOME}/agent.jar -jnlpUrl ${JENKINS_URL}/computer/${NODE_VALUE}/jenkins-agent.jnlp -secret ${SECRET} -workDir ${NODE_HOME}
User=root
Restart=always
RestartSec=10
StartLimitInterval=0

[Install]
WantedBy=multi-user.target
  " > /etc/systemd/system/jenkins-agent.service

systemctl enable jenkins-agent.service
systemctl start jenkins-agent.service