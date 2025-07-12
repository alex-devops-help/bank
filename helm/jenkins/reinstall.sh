#helm repo add jenkins-repo https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/chart;
#helm repo update jenkins-repo;

#helm uninstall --namespace jenkins jenkins-operator-r1;
#helm install jenkins-operator-r1 jenkins-repo/jenkins-operator --namespace jenkins --create-namespace -f values.yml;
#kubectl delete jenkins jenkins -n default;

kubectl create ns jenkins;

#Jenkins CRD:
kubectl -n jenkins apply -f https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/config/crd/bases/jenkins.io_jenkins.yaml;

#Operator and other required resources:
kubectl -n jenkins apply -f https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/deploy/all-in-one-v1alpha2.yaml;

kubectl get pods -n jenkins;
