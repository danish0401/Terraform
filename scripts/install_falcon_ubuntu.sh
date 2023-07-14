aws s3 cp s3://crowdstrike-binaries/falcon-sensor/ubuntu/falcon-sensor_6.56.0-15309_amd64.deb .
sudo dpkg -i falcon-sensor_6.56.0-15309_amd64.deb
sudo /opt/CrowdStrike/falconctl -s --cid=35871CD9666F441997742162B098D589-E9
sudo service falcon-sensor start
sudo /opt/CrowdStrike/falconctl -s --tags="falcon-installed-Ubuntu-20" -f
sudo service falcon-sensor restart