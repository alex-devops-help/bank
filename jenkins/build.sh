set -x;

KubeRegistryHost=registry.kube-system.svc.cluster.local;
RegistryImage="registry.kube-system.svc.cluster.local:30050/jenkins:custom-v1";

docker build . -t jenkins:custom-v1;

docker tag 	jenkins:custom-v1 	$RegistryImage;
docker push 	$RegistryImage;

curl http://minikube:30050/v2/_catalog;
curl http://minikube:30050/v2/jenkins/tags/list;
