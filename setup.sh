# https://argoproj.github.io/argo-workflows/quick-start/

minikube start

kubectl create namespace argo
# Get latest argo release from https://github.com/argoproj/argo-workflows/releases
kubectl apply -n argo -f https://github.com/argoproj/argo-workflows/releases/download/v3.4.3/install.yaml
while [[ $(kubectl get pods -n argo --no-headers -o jsonpath='{.items[0].status.phase}') != "Running" ]]; do
   echo 'waiting for argo pods...'
   sleep 3
done

kubectl patch deployment \
  argo-server \
  --namespace argo \
  --type='json' \
  -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/args", "value": [
  "server",
  "--auth-mode=server"
]}]'

# https://argoproj.github.io/argo-events/installation/
kubectl create namespace argo-events
kubectl apply -f https://raw.githubusercontent.com/argoproj/argo-events/stable/manifests/namespace-install.yaml
kubectl apply -n argo-events -f https://raw.githubusercontent.com/argoproj/argo-events/stable/examples/eventbus/native.yaml
while [[ $(kubectl get pods -n argo-events --no-headers -o jsonpath='{.items[0].status.phase}') != "Running" ]]; do
   echo 'waiting for argo events pods...'
   sleep 3
done

kubectl apply -n argo-events -f argo-event-webhook.yaml
kubectl apply -n argo-events -f argo-event-sensor.yaml