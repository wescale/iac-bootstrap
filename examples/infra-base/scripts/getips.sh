#!/bin/bash
echo '[bastion]' >> inventory;

aws autoscaling describe-auto-scaling-instances --region eu-west-1 --output text --query "AutoScalingInstances[?AutoScalingGroupName=='bastion'].InstanceId" | xargs -n1 aws ec2 describe-instances --instance-ids $ID --region eu-west-1 --query "Reservations[].Instances[].PublicIpAddress" --output text >> inventory
#echo "Bastion Private Ip ";

aws autoscaling describe-auto-scaling-instances --region eu-west-1 --output text --query "AutoScalingInstances[?AutoScalingGroupName=='bastion'].InstanceId" | xargs -n1 aws ec2 describe-instances --instance-ids $ID --region eu-west-1 --query "Reservations[].Instances[].PrivateIpAddress" --output text >> inventory
echo "[nginx]" >> inventory;

aws autoscaling describe-auto-scaling-instances --region eu-west-1 --output text --query "AutoScalingInstances[?AutoScalingGroupName=='nginx'].InstanceId" | xargs -n1 aws ec2 describe-instances --instance-ids $ID --region eu-west-1 --query "Reservations[].Instances[].PrivateIpAddress" --output text >> inventory

aws autoscaling describe-auto-scaling-instances --region eu-west-1 --output text --query "AutoScalingInstances[?AutoScalingGroupName=='bastion'].InstanceId" | xargs -n1 aws ec2 describe-instances --instance-ids $ID --region eu-west-1 --query Reservations[].Instances[].PrivateIpAddress --output text
