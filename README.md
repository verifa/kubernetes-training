# Kubernetes Training

There is more content being added to this repository...

## Table of Contents

1. General Introduction (this page)
2. [Storage](storage/README.md)

## 1. Minikube and kubectl preparation

### Set hyperkit as default driver and start minikube
```bash
minikube config set driver hyperkit
minikube start
```

### Setup context
```bash
kubectx minikube
```

### Create namespace
```bash
kubectl create -f namespace.yaml
```

### Setup default namespace
```bash
kubectl config set-context --current --namespace nginx-namespace
```

## 2. Use local docker image

### Set docker env
```bash
eval $(minikube docker-env)
```

### Build image
```bash
docker build --no-cache -t ubuntu:local .
```

### Testrun in minikube
```bash
kubectl run ubuntu-local --image=ubuntu:local --image-pull-policy=Never sleep 100
kubectl get pods
kubectl exec -ti ubuntu-local -- bash
kubectl delete pods ubuntu-local
```

## 3. Pod with nodeport service and ubuntu sidecar

### Create pod and service and check endpoint
```bash
kubectl create -f pod.yaml
kubectl create -f service.yaml
kubectl describe endpoints nginx-service
```

### Test service and pod with sidecar
```bash
kubectl exec -ti nginx-pod -c ubuntu-container -- bash
ifconfig
nslookup nginx-service
curl localhost
```

### Test service from different pod
```bash
kubectl run -ti --rm ubuntu-local --image=ubuntu:local -- bash
curl nginx-service
```

### Test nodeport from vm
```bash
minikube ssh
ifconfig
curl localhost:30973
```

## 4. Replicaset with nodeport service

### Create replicaset and service and check endpoints
```bash
kubectl create -f replicaset.yaml
kubectl create -f replicaset-service.yaml
kubectl describe endpoints nginx-replicaset-service
```
