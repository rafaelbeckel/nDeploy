#!/bin/bash

if [ $2 -eq 1 ] ; then
	CPANELUSER=$(stat -c "%U" /opt/nDeploy/domain-data/$1)
else
	CPANELUSER=$(echo $1)
fi

if [[ $CPANELUSER == *.lock || $CPANELUSER == .* ]];then
	exit 0
else
	(
	         flock -x -w 300 500
		 	/opt/nDeploy/scripts/generate_config.py $CPANELUSER
	) 500>/opt/nDeploy/lock/$CPANELUSER.lock		
	rm -f /opt/nDeploy/lock/$CPANELUSER.lock
fi
