set -x;

if ! [ -f ./install.sh ]; then
	./download.sh
fi;

kubectl delete -n keycloak keycloak bank || ( kubectl create ns keycloak; ./install.sh v0.32.0 && sleep 35s);
kubectl apply -f keycloak-operator.yml && sleep 35s;
kubectl apply -f bank-instance.yml && sleep 75s;

bash -lc "kubectl -n keycloak logs pod/bank-0 -f";

./status.sh;

/project/utils/load_json_clients.sh;

#./password.sh;
