# E-Shop on Kubernetes

## Deploy

### Preparing
1. Create an account on Yandex Cloud (if you don't have one).
2. Run command:
`mv .env.example .env`
and insert your environment variables there.
3. Launch Terraform: `./apply.sh`
4. Take IPs printed after previous command was done & write them at the hosts.ini file.
5. Setup servers:
`./ansible.sh`
6. Setup Kubernetes:
```
kubeadm init --control-plane-endpoint 172.16.. --upload-certs --pod-network-cidr 192.168.0.0/16 | tee -a kubeadm.log
kubeadm join ...:6443 --token ... --discovery-token-ca-cert-hash sha256:... --control-plane --certificate-key
```
7. Run command:
`./master.sh`
8. Take a Kube config from the newly created file - `config_encoded` & paste its content in a Gitlab Secret KUBE_CONFIG

### Application
1. Create application services:
`./master.sh`
2. Make a commit, push it, Gitlab runner will install loadgenerator's helm chart, then.
3. Setup port-forwarding for Prometheus, Grafana.

