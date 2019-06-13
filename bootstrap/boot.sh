#!/bin/sh
curl -sL https://rpm.nodesource.com/setup_12.x | sudo bash -

yum install -y nodejs,sshpass

npm i -g k8sboot
