#!/bin/bash

echo "[1] Iniciando minikube"
minikube start --network-plugin=cni --cni=calico
echo "[2] Desplegar aplicaciones"
kubectl apply -f deploy1.yaml
kubectl apply -f deploy2.yaml
kubectl apply -f deploy3.yaml
echo "[3] Desplegar Politica por defecto (denegar)"
kubectl apply -f deny-all.yaml
echo "[4] Desplegar Politica permitir desde contenedor1 a contenedor2"
kubectl apply -f allow_c1_to_c2.yaml
echo "FIN"
