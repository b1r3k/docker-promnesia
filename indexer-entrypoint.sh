#!/bin/bash

# note: https://lostindetails.com/articles/How-to-run-cron-inside-Docker
# note: CRONTAB is set in docker-compose.yaml.

# Start the run once job.
echo "Promnesia indexer container has been started"

declare -p | grep -Ev 'BASHOPTS|BASH_VERSINFO|EUID|PPID|SHELLOPTS|UID|MY_CONFIG|XDG_CONFIG_HOME' > /container.env

# Setup a cron schedule
echo "SHELL=/bin/bash
BASH_ENV=/container.env
*/10 * * * * python -m promnesia index --config /data/promnesia/config.py > /var/log/cron.log 2>&1"
# This extra line makes it a valid cron" | sudo -u ${PROMNESIA_USER} crontab -

echo "Crontab job defined for user: ${PROMNESIA_USER}, starting cron..."

cron
tail -f /var/log/cron.log
