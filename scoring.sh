#!/bin/bash
 
# My "scoring AWS" script
 
aws s3 ls                      
aws s3 cp s3://xxx/aws-summit-london/sample_scr_batch_payload.json /tmp/sample_scr_batch_payload.json
aws eks --region eu-west-2 update-kubeconfig --name summit-london-eks
kubectl get nodes
ls -ltr /tmp

kubectl scale deployment -n sas-modelops-deployments hmeqtestgradientboosting --replicas=1
kubectl wait pods -n sas-modelops-deployments -l app.kubernetes.io/name=hmeqtestgradientboosting --for condition=Ready --timeout=120s

echo $(curl ident.me)

echo "50sec sleep start"
sleep 50
echo "sleep over"
cd /tmp
timestamp=$(date +""%d%m%y_%H%M%S)
echo $timestamp
cat /etc/hosts
#curl -X POST -H "Content-Type: application/json" -d @sample_scr_batch_payload.json http://k8s-sasmodel-hmeqtest-xxx-xxxx.elb.eu-west-2.amazonaws.com/score -o /tmp/out.json
 
curl -X POST -H "Content-Type: application/json" -m 10 -d @sample_scr_batch_payload.json http://k8s-sasmodel-hmeqtest-xxx-xxx.elb.eu-west-2.amazonaws.com/score -o /tmp/out.json
cat out.json | jq '.'  > out_$timestamp.json


#ls -ltr /tmp
aws s3 cp /tmp/out_$timestamp.json s3://xxx/aws-summit-london/out_$timestamp.json
cat /tmp/out_$timestamp.json
kubectl scale deployment -n sas-modelops-deployments hmeqtestgradientboosting --replicas=0
#sleep 120s
