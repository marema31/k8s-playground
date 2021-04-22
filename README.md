# Learning playground for k8s, helmfiles and k3d

## Cluster k3d
Start the cluster
```bash
k3d cluster create newcluster -p "80:80@loadbalancer" --registry-use k3d-registry.k3d.lan.carmier.fr:5000 --k3s-server-arg "--no-deploy=traefik"
```

Delete the cluster
```bash
k3d cluster delete newcluster
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