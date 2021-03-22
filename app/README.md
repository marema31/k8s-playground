zjW4u9HS7yZqrpD

docker login marc eqtoqjwe.gra5.container-registry.ovh.net/private

docker build -t eqtoqjwe.gra5.container-registry.ovh.net/private/loadtest:latest .

docker push eqtoqjwe.gra5.container-registry.ovh.net/private/loadtest:latest

# Ajouter les credentials comme secrets
kubectl create secret docker-registry regcred --docker-server=eqtoqjwe.gra5.container-registry.ovh.net --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>
