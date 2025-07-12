set -x;

status()
{
        kubectl -n olm get all;
        kubectl -n olm describe subscription keycloak-operator;
       
        kubectl -n keycloak get all;
        kubectl -n keycloak describe keycloak bank;

        kubectl -A get installplan,csv,pods;
} 

status;