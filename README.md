# Learning playground for k8s, helmfiles and k3d

## Cluster k3d
Start the cluster without integrated Traefik 1.7
```bash
k3d cluster create mycluster -p "80:80@loadbalancer" --registry-use k3d-registry.k3d.lan.carmier.fr:5000 --k3s-server-arg "--no-deploy=traefik"

k3d kubeconfig merge mycluster --kubeconfig-switch-context
```

Install Traefik 2.x
```bash
helm repo add traefik https://containous.github.io/traefik-helm-chart
helm install traefik traefik/traefik
```

To access Traefik dashboard on http://localhost:9000
```bash
kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000
```

Delete the cluster
```bash
k3d cluster delete newcluster
```

## Application container

Build and push the image to k3d registry
_Note_: Due to HTTPS/HTTP limitation we need to push to localhost but the k8s will refer with the name provided on k3d spawn.

```bash
docker build -t localhost:5000/loadtest .
docker push localhost:5000/loadtest
```

## Helmfile
Start the application
```bash
helmfile --environment python-dev   apply
```

Delete the application
```bash
helmfile --environment python-dev   delete
```


## Notes
### Add registry credentials as secrets (if needed)
kubectl create secret docker-registry regcred --docker-server=myregistry --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>