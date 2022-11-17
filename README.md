# test-k8s-argo

- [Inspiration](https://www.youtube.com/watch?v=MeU5_k9ssrs)
- [jsonnet usage](https://argo-cd.readthedocs.io/en/stable/user-guide/jsonnet/)

## Pre-reqs

```sh
brew install --cask docker
brew install kubectl
brew install kubecfg
brew install minikube
brew install argocd
```

## [Install locally](https://argo-cd.readthedocs.io/en/stable/getting_started/)

- Start docker desktop
- Start minikube `minikube start`
- Run below setup script

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

## Setup

- Open port-forward with `kubectl port-forward svc/argocd-server -n argocd 8080:443`
- (wait for pods) Obtain default password with `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
- Login with admin user as per below

```sh
argocd login localhost:8080 
WARNING: server certificate had error: x509: “Argo CD” certificate is not trusted. Proceed insecurely (y/n)? y
Username: admin
Password: 
'admin:login' logged in successfully
Context 'localhost:8080' updated
```

- Update password via `argocd account update-password`
- Check new password by re-running `argocd login localhost:8080`
- Delete initial password secret with `kubectl delete secret -n argocd argocd-initial-admin-secret`

## UI

- Access UI via `https://localhost:8080/login?`

## Jsonnet

- Kubernetes manifests are built from json files. YAML can be produced as per below.

```sh
kubecfg show -o yaml manifests/namespace.jsonnet
```

## Deploy app (connect to git)

- *IMPORTANT*: Change `[YOU]` to match your github url in `argocd-app.yaml`

- Connect to Git via `https://localhost:8080/settings/repos?addRepo=true`
  - Make your life easy by marking as public (for testing)

- Create app `kubectl apply -f argocd-app.yaml -n argocd`

- App can be seen at `https://localhost:8080/applications?`

## NOTES

- Argocd will update from the repo every 3 minutes (be patient!)
