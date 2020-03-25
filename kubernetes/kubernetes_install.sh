#!/bin/bash
echo "Añadir repositorios"
add-apt-repository universe
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
echo "Instalar kubernetes"
apt-get update && apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni
echo "Quitar la swap"
swapoff -a
echo "Reiniciar el servicio "
systemctl daemon-reload && systemctl restart kubelet
echo "Solo en el master"
#kubeadm init --pod-network-cidr=10.0.0.0/16
echo "Instalar sistema de networking"
#kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
