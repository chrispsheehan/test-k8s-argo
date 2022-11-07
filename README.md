# test-k8s-argo

## Pre-reqs

- `brew install kubernetes-cli@1.22`

- `brew install --cask docker`

- `brew install minikube`

- `brew install argo`

## Setup

`sh ./setup.sh`

## Dashboard

Run the below to access via `localhost:2746/workflows?` with the below.

```sh
kubectl config use-context minikube
kubectl -n argo port-forward deployment/argo-server 2746:2746
```



