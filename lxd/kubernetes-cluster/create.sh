#!/bin/bash
echo "Creando master..."
lxc launch ubuntu:18.04 kmaster --profile k8s
sleep 10
echo "Creando worker1..."
lxc launch ubuntu:18.04 kworker1 --profile k8s
echo "Creando worker2..."
lxc launch ubuntu:18.04 kworker2 --profile k8s
sleep 10
echo "Aprovisionando master ..."
cat bootstrap-ubuntu.sh | lxc exec kmaster bash
sleep 5
echo "Aprovisionando worker1..."
cat bootstrap-ubuntu.sh | lxc exec kworker1 bash
echo "Aprovisionando worker2..."
cat bootstrap-ubuntu.sh | lxc exec kworker2 bash
sleep 5
echo "Borrando fichero config..."
rm .kube/config
echo "Descargando fichero nuevo..."
lxc file pull kmaster/etc/kubernetes/admin.conf .kube/config
echo "Comprobando fichero..."
kubectl cluster-info
echo "Comprobando nodos..."
kubectl get nodes

echo "FIN"