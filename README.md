# test-k8s-argo

## Pre-reqs

- `brew install kubectl`

- `brew install --cask docker`

- `brew install minikube`

- `brew install argo`

## Get started

Intial setup with `sh ./setup.sh` or switch context via `kubectl config use-context minikube`

## Dashboard

Run the below to access via `localhost:2746/workflows?` with the below.

```sh
kubectl -n argo port-forward deployment/argo-server 2746:2746
```

## Hit Webhook

```sh
kubectl -n argo-events port-forward $(kubectl -n argo-events get pods -l eventsource-name=webhook --field-selector=status.phase==Running -o jsonpath="{.items[0].metadata.name}") 12000:12000
```

```sh
curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:12000/github
```