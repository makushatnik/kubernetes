# E-Shop on Kubernetes

## Deploy

### Preparing
1. Create an account on Yandex Cloud (if you don't have one).
2. Getting YCloud token:
`yc iam create-token`
3. Write this token to terraform/yandex/vars.tf at the yc_token variable.
4. Creating servers as much as needed:
`terraform apply`
5. Take IPs printed after previous command was done & write them at the hosts.ini file.
6. Setup servers:
`ansible-playbook -i hosts.ini kube-ansible.yml`
7. Setup Kubernetes:
```
kubeadm init --control-plane-endpoint 172.16.. --upload-certs --pod-network-cidr 192.168.0.0/16 | tee -a kubeadm.log
kubeadm join ...:6443 --token ... --discovery-token-ca-cert-hash sha256:... --control-plane --certificate-key
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/baremetal/deploy.yaml
```
8. Find out which particular port used by Ingress Nginx Controller:
`kubectl get svc -n ingress-nginx`
9. Change port 32000 to this port at lb machine in the HAProxy config:
```
nano /etc/haproxy/haproxy.cfg
    http <port>
systemctl restart haproxy
```

### Application
1. kubectl create -f kubernetes-manifests.yaml
2. Create Ingress:
`kubectl create -f ingress.yml`
3. docker build https://github.com/GoogleCloudPlatform/microservices-demo.git#main:src/loadgenerator -t loadgenerator
4. Generate SSH key for Git:
`ssh-keygen -o`
5. Load the repository:
`git clone ssh://github.com/makushatnik/kubernetes.git && cd kubernetes/step2/loadgenerator`
6. Install Helm chart:
`helm upgrade --install loadgenerator . --version 1.0.0`


### Create DOCKER_JSON
1. `docker login registry.gitlab.com -u <USER> -p <PASSWORD>`
2. Run a command:
`cat .docker/config.json | base64`
3. Copy a cypher, go to Gitlab Secrets page & paste in a new variable - DOCKER_CONFIG.

### Start runner
1. `ssh ubuntu@<worker_ip>`
2. Install runner:
`cmd`

