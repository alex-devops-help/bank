
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
		cp $File ./client_json_files/;
		docker exec -ti keycloak /opt/keycloak/bin/kcadm.sh create clients -r master -f /client_json_files/$Module.json  --server http://localhost:8080 --realm master --user admin --password admin;
	else
		echo "===> Missing $File";
	fi;

}

for ClientName in accounts blocker cash exchange exchange-generator front-ui notifications transfer; do
	load_client2 $ClientName;
done



