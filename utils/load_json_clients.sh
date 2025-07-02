#!/usr/bin/env bash

#set -x;

#load_client()
#{
#	local Dir=$1;
#
#        docker run \
#            -e KEYCLOAK_URL="http://keycloak:8080/" \
#            -e KEYCLOAK_USER="admin" \
#            -e KEYCLOAK_PASSWORD="admin" \
#            -e KEYCLOAK_AVAILABILITYCHECK_ENABLED=true \
#            -e KEYCLOAK_AVAILABILITYCHECK_TIMEOUT=120s \
#            -e IMPORT_FILES_LOCATIONS="/config/*.json" \
#            -v $Dir:/config \
#            --network bank_default \
#            adorsys/keycloak-config-cli:latest;
#            
#      	 return $?;
#}

#load_client /project/accounts/src/main/resources && echo $?;

load_client2()
{
	Module=$1;
	
	File=/project/$Module/src/main/resources/$Module.json;
	if [ -f $File ]; then
#		if ! [ -d /client_json_files ]; then
#			mkdir /client_json_files;
#		fi;
#		cp $File /client_json_files/;
		docker exec -ti keycloak /opt/keycloak/bin/kcadm.sh create clients -r master -f $File  --server http://localhost:8080 --realm master --user admin --password admin;
#		/client_json_files/$Module.json
	else
		echo "===> Missing $File";
		exit 1;
	fi;

}

for ClientName in accounts cash exchange front-ui transfer; do #accounts blocker cash exchange exchange-generator front-ui notifications transfer
	load_client2 $ClientName;
done;

exit 0;
