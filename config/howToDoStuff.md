# How-To

## Update ops machine
- ~/PROJECTS/MFund-Services/config/update-ops.sh

## Update deploy machine
- ~/PROJECTS/MFund-Services/config/update-deploy.sh

## Create or Update finset from sec files
    cik_file=$"data/123.csv"
    python -c 'import app.update as up; up.update_finset("$cik_file")'


## update blog posts
    cd ~/PROJECTS/MFund-Services
    hugo --config hugo-themes/MFund-Services/config.toml
    gsutil -m rsync -d -r .MFund-Services.com gs://MFund-Services.com
    
## copy exclude to git
    cp config/exclude.txt .git/info/exclude.txt



