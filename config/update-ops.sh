#!/bin/bash
# execute without sudo to avoid $HOME change
echo "Sync and upgrade ops machine. It includes crontab scheduler, nginx, etc."
date
### copy deploy-job and nginx to control
gcloud compute scp ~/PROJECTS/MFund-Services/config/nginx.conf manav@ops:~/PROJECTS/MFund-Services/config
gcloud compute scp ~/PROJECTS/Mfund-Services/config/daily-deploy-job.sh manav@ops:~/PROJECTS/MFund-Services/config

gcloud compute ssh manav@ops <<update-ops
cd ~/PROJECTS/MFund-Services
sudo cp config/nginx.conf /etc/nginx/nginx.conf # copy customized nginx.config
sudo nginx -s reload

crontab -r # remove crontab: scheduled jobs
#crontab -l | grep -v 'config/daily-tasks.sh' | crontab - # remove from crontabl scheduler
crontab -l | { cat; echo "35 3,23 * * * bash ~/PROJECTS/MFund-Services/config/daily-deploy-job.sh"; } | crontab - #run daily-deploy-job
crontab -l | { cat; echo "35 4 * * 2 mv ~/PROJECTS/MFund-Services/.log/*.log ~/PROJECTS/MFund-Services/.log/archive"; } | crontab - #archive log files every tuesdays
crontab -l
update-ops
date
echo Sync and upgrading control-machine is done.

