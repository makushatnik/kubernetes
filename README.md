# E-Shop on Kubernetes

## Deploy

### Preparing
1. Create an account on Yandex Cloud (if you don't have one).
2. Run command:
`mv .env.example .env`
and insert your oauth token there.
3. Launch Terraform: `./apply.sh`
4. Take IPs printed after previous command was done & write them at the hosts.ini file.
5. Setup servers:
`ansible-playbook -i hosts.ini kube-ansible.yml`
6. Setup Kubernetes:
```
kubeadm init --control-plane-endpoint 172.16.. --upload-certs --pod-network-cidr 192.168.0.0/16 | tee -a kubeadm.log
kubeadm join ...:6443 --token ... --discovery-token-ca-cert-hash sha256:... --control-plane --certificate-key
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.1/deploy/static/provider/baremetal/deploy.yaml
```
7. Find out which particular port used by Ingress Nginx Controller:
`kubectl get svc -n ingress-nginx`
8. Change port 32000 to this port at lb machine in the HAProxy config:
```
nano /etc/haproxy/haproxy.cfg
    server http<num> <ip>:<port>
systemctl restart haproxy
```
9. Ssh to any of master, take a kube config:
`cat .kube/config | base64`
and insert in a Gitlab Secret KUBE_CONFIG

### Application
1. Create application services:
`kubectl create -f kubernetes-manifests.yaml`
2. Create Ingress:
`kubectl create -f ingress.yml`
#3. Install Helm chart:
#`helm upgrade --install loadgenerator . --version 1.0.0`
3. Run commands:
```
helm repo add gitlab https://charts.gitlab.io
helm install gitlab-runner \
  --set gitlabUrl=https://gitlab.com \
  --set runnerRegistrationToken=<runner token> \
  --set rbac.create=true \
  gitlab/gitlab-runner
```
4. Make a commit, push it, Gitlab runner will install loadgenerator's helm chart, then.



