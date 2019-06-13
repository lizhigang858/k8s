#! /bin/sh
# 安装一个三节点的k8s集群，每个2核4G
gcloud container clusters create istio-tutorial \
    --disk-size=10GB \
    --num-nodes=3 \
    --machine-type=custom-2-4096

#下载istio
curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.8 sh -

cd istio-1.1.8

export PATH=$PWD/bin:$PATH


kubectl create clusterrolebinding cluster-admin-binding \
  --clusterrole=cluster-admin \
  --user="$(gcloud config get-value core/account)"

kubectl apply -f install/kubernetes/istio-demo-auth.yaml

#部署bookinfo
kubectl apply -f <(istioctl kube-inject -f samples/bookinfo/platform/kube/bookinfo.yaml)
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

#获取服务ip，然后访问/productpage
kubectl get svc istio-ingressgateway -n istio-system