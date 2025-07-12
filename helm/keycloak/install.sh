set -x;

if ! [ -f olm/install.sh ]; then
	./download.sh
fi;

( kubectl get -n keycloak keycloak bank || ( kubectl create ns keycloak; olm/install.sh v0.32.0; echo "Result: $?"; sleep 35s ) ) && \
kubectl apply -f keycloak-operator.yml && sleep 35s && ./recreate.sh;

#kubectl apply -f bank-instance.yml && sleep 75s && \
#./status.sh && \
#/project/utils/load_json_clients.sh;

#./password.sh;
#bash -lc "kubectl -n keycloak logs pod/bank-0 -f";
