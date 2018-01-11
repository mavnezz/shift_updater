#!/bin/bash

# Shift version to update to
version=$(curl -s 'https://raw.githubusercontent.com/mavnezz/shift_updater/master/shift_version')

if [ -e $version ]
then
    echo "Version $version allready installed"
else
	crontab -r
	echo "* * * * * php ~/shift-checker/checkdelegate.php >> ~/shift-checker/logs/checkdelegate.log 2>&1" > cronjob.out
	echo "0 1 * * * ./shift_updater.sh" >> cronjob.out
	echo "@daily forever cleanlogs" 	>> cronjob.out
	
	echo "Updating shift to version $version"
	echo "Updating Client"
	~/shift/shift_manager.bash update_client
	echo "Updating Wallet"
	~/shift/shift_manager.bash update_wallet
	echo "Shift updated to version $version"
    echo $version > $version
	crontab cronjob.out
fi
