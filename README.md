# test-k8s-argo

[Inspiration](https://www.youtube.com/watch?v=MeU5_k9ssrs)

## Pre-reqs

```sh
brew install --cask docker
brew install kubectl
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

## Dashboard

- Open port-forward with `kubectl port-forward svc/argocd-server -n argocd 8080:443`
- Access UI via `https://localhost:8080/login?`
- Obtain deafault password with `kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo`
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
