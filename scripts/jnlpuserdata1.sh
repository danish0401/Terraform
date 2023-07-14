#!/bin/bash
sudo yum update -y
sudo yum install wget -y
sudo amazon-linux-extras install java-openjdk11 -y
sudo amazon-linux-extras install epel -y

JENKINS_URL=$(aws ssm get-parameter --name jenkins_URL --query 'Parameter.Value' --region us-west-2 --output text)
NODE_NAME="agent-$(hostname -I)"
NODE_HOME='/home/ec2-user/jenkins_agent'
CLI_HOME='/home/ec2-user/jenkins_agent/jenkins_cli'
EXECUTORS=1
SSH_PORT=22
USERID=$(aws ssm get-parameter --name Jenkins_USERID --query 'Parameter.Value' --region us-west-2 --output text)
LABELS="Slave-$(hostname -I)"
TOKEN=$(aws ssm get-parameter --name Jenkins_Token --query 'Parameter.Value' --region us-west-2 --output text)
mkdir -p $CLI_HOME && cd $CLI_HOME
NODE_URL=$(echo $NODE_NAME)
wget $JENKINS_URL/jnlpJars/jenkins-cli.jar    

cat <<EOF | java -jar $CLI_HOME/jenkins-cli.jar -s $JENKINS_URL -auth $USERID:$TOKEN create-node $NODE_NAME
<slave>
  <name>${NODE_NAME}</name>
  <description>This is new agent named ${NODE_NAME}</description>
  <remoteFS>${NODE_HOME}</remoteFS>
  <numExecutors>${EXECUTORS}</numExecutors>
  <mode>EXCLUSIVE</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher">
    <workDirSettings>
      <disabled>false</disabled>
      <internalDir>remoting</internalDir>
      <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
    </workDirSettings>
    <webSocket>true</webSocket>
  </launcher>
  <label>${LABELS}</label>
  <nodeProperties/>
</slave>
EOF

cd $NODE_HOME
wget $JENKINS_URL/jnlpJars/agent.jar
SECRET=$(curl -s -u $USERID:$TOKEN $JENKINS_URL/computer/$NODE_URL/jenkins-agent.jnlp | sed -e 's/<[^>]*.//g' | cut -c 1-64 )
echo $SECRET > secret-file
/usr/bin/nohup java -jar agent.jar -jnlpUrl $JENKINS_URL/computer/$NODE_URL/jenkins-agent.jnlp -secret @secret-file -workDir $NODE_HOME &

# systemd code to delete node when instance is down
cat >> /home/ec2-user/script.sh << EOL
#!/bin/bash
EOL
echo "sudo su - root -c \"/usr/bin/java -jar $CLI_HOME/jenkins-cli.jar -s $JENKINS_URL -auth $USERID:$TOKEN delete-node $NODE_NAME\"" >> /home/ec2-user/script.sh
chmod +rwx /home/ec2-user/script.sh

cat >> /usr/lib/systemd/system/shutdown.service <<EOF
[Unit]
Description=my_shutdown Service
Before=shutdown.target reboot.target halt.target
Requires=network-online.target network.target
[Service]
KillMode=none
ExecStart=/bin/true
ExecStop=/home/ec2-user/script.sh
RemainAfterExit=true
Type=oneshot
[Install]
WantedBy=multi-user.target
EOF
systemctl enable shutdown.service
systemctl start shutdown.service
systemctl daemon-reload


# Read me

# First i Learned Jenkins-CLI than written a config.xml file than found out
# that its easily available

# node was created and connected successfully on thursday but deletion of node based on instance termination was a good task
# first I look ASG group lifecycle hookup but failed then tried using other methods
# at last created a systemd/service/shutdown.service which worked successfully :)



# #!/bin/bash
# sudo yum update -y
# sudo yum install wget -y
# sudo amazon-linux-extras install java-openjdk11 -y
# sudo amazon-linux-extras install epel -y

# JENKINS_URL=$(aws ssm get-parameter --name jenkins_URL --query 'Parameter.Value' --region us-west-2 --output text)
# NODE_NAME="agent-$(hostname -I)"
# NODE_HOME='/home/ec2-user/jenkins_agent'
# CLI_HOME='/home/ec2-user/jenkins_agent/jenkins_cli'
# EXECUTORS=1
# SSH_PORT=22
# USERID=$(aws ssm get-parameter --name Jenkins_USERID --query 'Parameter.Value' --region us-west-2 --output text)
# LABELS="Slave-$(hostname -I)"
# TOKEN=$(aws ssm get-parameter --name Jenkins_Token --query 'Parameter.Value' --region us-west-2 --output text)
# mkdir -p $CLI_HOME && cd $CLI_HOME
# NODE_URL=$(echo $NODE_NAME)
# wget $JENKINS_URL/jnlpJars/jenkins-cli.jar    

# cat <<EOF | java -jar $CLI_HOME/jenkins-cli.jar -s $JENKINS_URL -auth $USERID:$TOKEN create-node $NODE_NAME
# <slave>
#   <name>${NODE_NAME}</name>
#   <description>This is new agent named ${NODE_NAME}</description>
#   <remoteFS>${NODE_HOME}</remoteFS>
#   <numExecutors>${EXECUTORS}</numExecutors>
#   <mode>EXCLUSIVE</mode>
#   <retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/>
#   <launcher class="hudson.slaves.JNLPLauncher">
#     <workDirSettings>
#       <disabled>false</disabled>
#       <internalDir>remoting</internalDir>
#       <failIfWorkDirIsMissing>false</failIfWorkDirIsMissing>
#     </workDirSettings>
#     <webSocket>true</webSocket>
#   </launcher>
#   <label>${LABELS}</label>
#   <nodeProperties/>
# </slave>
# EOF

# cd $NODE_HOME
# wget $JENKINS_URL/jnlpJars/agent.jar
# SECRET=$(curl -s -u $USERID:$TOKEN $JENKINS_URL/computer/$NODE_URL/jenkins-agent.jnlp | sed -e 's/<[^>]*.//g' | cut -c 1-64 )
# echo $SECRET > secret-file
# /usr/bin/nohup java -jar agent.jar -jnlpUrl $JENKINS_URL/computer/$NODE_URL/jenkins-agent.jnlp -secret @secret-file -workDir $NODE_HOME &

# # systemd code to delete node when instance is down
# cat >> /home/ec2-user/script.sh << EOL
# #!/bin/bash
# EOL
# echo "sudo su - root -c \"java -jar $CLI_HOME/jenkins-cli.jar -s $JENKINS_URL -auth $USERID:$TOKEN delete-node $NODE_NAME\"" >> /home/ec2-user/script.sh
# chmod +rwx /home/ec2-user/script.sh

# cat >> /usr/lib/systemd/system/shutdown.service <<EOF
# [Unit]
# Description=my_shutdown Service
# Before=shutdown.target reboot.target halt.target
# Requires=network-online.target network.target
# [Service]
# KillMode=none
# ExecStart=/bin/true
# ExecStop=/home/ec2-user/script.sh
# RemainAfterExit=true
# Type=oneshot
# [Install]
# WantedBy=multi-user.target
# EOF
# systemctl enable shutdown.service
# systemctl start shutdown.service
# systemctl daemon-reload