aws s3 cp s3://crowdstrike-falcon-binaries/falcon-sensor/amzn-linux-2/falcon-sensor-6.56.0-15309.amzn2.x86_64.rpm .
sudo yum install -y falcon-sensor-6.56.0-15309.amzn2.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=35871CD9666F441997742162B098D589-E9
sudo service falcon-sensor start
sudo /opt/CrowdStrike/falconctl -s --tags="prod_solr,falcon-via-terminal" -f
sudo service falcon-sensor restart

ps aux | grep falcon-sensor
systemctl status falcon-sensor.service


# for Centos

# first install unzip and aws cli

aws s3 cp s3://crowdstrike-falcon-binaries/falcon-sensor/centos-7/falcon-sensor-6.56.0-15309.el7.x86_64.rpm .
sudo yum install -y falcon-sensor-6.56.0-15309.el7.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=35871CD9666F441997742162B098D589-E9
sudo service falcon-sensor start
sudo /opt/CrowdStrike/falconctl -s --tags="prod_solr,falcon-via-terminal" -f
sudo service falcon-sensor restart