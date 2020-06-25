#!/bin/bash

echo "[TASK 1] Instalar docker y kubernetes"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list
echo "Actualizando repositorio ..."
apt-get update >/dev/null 2>&1
echo "Instalando paquetes ..."
apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni >/dev/null 2>&1

echo "[TASK 2] Habilitar docker"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

echo "[TASK 3] Instalar y configurar ssh"
apt-get install -y openssh-server >/dev/null 2>&1
sed -i 's/.*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
echo "PermitRootLogin yes"  >> /etc/ssh/sshd_config
systemctl enable sshd >/dev/null 2>&1
systemctl restart sshd >/dev/null 2>&1

echo "[TASK 4] Crear la password de root"
echo "root:kubeadmin" | chpasswd >/dev/null 2>&1

echo "[TASK 5] Instalar paquetes adicionales"
apt-get install -y net-tools sudo sshpass less >/dev/null 2>&1
mknod /dev/kmsg c 1 11

if [[ $(hostname) =~ .*master.* ]]
then

  echo "[TASK 6] Inicializar Cluster"
  kubeadm init --pod-network-cidr=10.22.0.0/16 --ignore-preflight-errors=all >> /root/kubeinit.log 2>&1

  echo "[TASK 7] Copiar fichero de configuración"
  mkdir /root/.kube
  cp /etc/kubernetes/admin.conf /root/.kube/config

  echo "[TASK 8] Desplegar Weave"
  kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')" > /dev/null 2>&1

  echo "[TASK 9] Generar comando kubeadm"
  joinCommand=$(kubeadm token create --print-join-command 2>/dev/null) 
  echo "$joinCommand --ignore-preflight-errors=all" > /joincluster.sh

fi

if [[ $(hostname) =~ .*worker.* ]]
then

  echo "[TASK 6] Unir worker al cluster"
  sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.lxd:/joincluster.sh /joincluster.sh 2>/tmp/joincluster.log
  bash /joincluster.sh >> /tmp/joincluster.log 2>&1

fi