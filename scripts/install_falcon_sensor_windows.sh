# install aws CLI
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
https://docs.aws.amazon.com/cli/v1/userguide/install-windows.html#awscli-install-windows-path
# add new file path c:\Program Files\Amazon\AWSCLIV2\aws.exe



# copy and installsasa

aws s3 cp s3://crowdstrike-falcon-binaries/falcon-sensor/windows/WindowsSensor.MaverickGyr.exe .
WindowsSensor.MaverickGyr.exe /install /quiet /norestart CID=35871CD9666F441997742162B098D589-E9 GROUPING_TAGS="prod_preprodiws_1,falcon-via-terminal"

# verify installation
sc.exe query csagent
