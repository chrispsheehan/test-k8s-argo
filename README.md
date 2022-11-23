# test-k8s-argo

- [Inspiration](https://www.youtube.com/watch?v=MeU5_k9ssrs)
- [jsonnet usage](https://argo-cd.readthedocs.io/en/stable/user-guide/jsonnet/)

## Prerequisites

```sh
brew install --cask docker
brew install kubectl
brew install kubecfg
brew install minikube
brew install argocd
```

## [Install locally](https://argo-cd.readthedocs.io/en/stable/getting_started/)

- Start docker desktop.
- Start minikube.
  - `minikube start`
- Run below setup script.

```sh
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

## Setup

- Wait for all pods status to = `Running`.
  - `kubectl get pods -n argocd`
- Obtain default password secret.
  - `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
- Open a [port-forward](https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/) to argocd.
  - `kubectl port-forward svc/argocd-server -n argocd 8080:443`
- Login with `admin` user and obtained default password by following prompts.
  - `argocd login localhost:8080`
- Once logged in. Update password.
  - `argocd account update-password`
- Check new password by logging in again.
  - `argocd login localhost:8080`
- [Optional] Delete initial password secret.
  - `kubectl delete secret -n argocd argocd-initial-admin-secret`

## UI

- Access UI via `https://localhost:8080/login?`

## Jsonnet

- Kubernetes manifests are built from json files. YAML can be generated as per below.

```sh
kubecfg show -o yaml jsonnet/namespace.jsonnet
```

## Deploy app (connect to git)

- *IMPORTANT*: To use your repo change `spec.source.repoURL` to your github url within `argocd-app.yaml`.

- Connect to Git via `https://localhost:8080/settings/repos?addRepo=true`
  - Make your life easy by marking as public (for testing). SSH is possible.

- Create argocd app.
  - `kubectl apply -f argocd-app.yaml -n argocd`

- App can be seen at `https://localhost:8080/applications?`

## NOTES

- Argocd will update from the repo every 3 minutes (be patient!)
