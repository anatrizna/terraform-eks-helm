## Disclamers
(1) SonarQube doesn't support MySQL since v7.9. Sonarqube Helm chart used in this project deploy sonarqube-9.5.1, thus postgres database used instead. But the logic itself is the same. Just wanted to avoid spending time on finding Sonarqube old version charts.

(2) K8s is provisioned in AWS cloud. Hope you don't mind.

(3) This project is extremely sceleton solution. Just enought for min requirements. There is an enormous amount of possible improvements before it serves for any real-world use-case.

## General description

This project use Terraform to provision AWS resources to host Kubernetes cluster. Cluster size can be configured in variables.tf.

## Pre-requised

awscli, terraform, kubectl, helm (v3)

## Instructions to setup and configure cluster

1. Downlaod this repo locally and configure your credentials in variables.tf `aws_access_key`, `aws_secure_key`.
2. Run `terraform init`, `terraform plan`, `terraform apply` in this project root holder and wait for EKS cluster to be created. It may take up to 15 minutes. 
After this step completed you will see new EKS cluster in AWS > EKS with the name you set in variables.tf `cluster-name`.
At this step the following resources will be provisioned: VPC, IAM roles, Security groups, Internet gateway, Subnets, Autoscaling group, Route table, EKS cluster.
3. Setup communication between you and AWS EKS cluster. Run the following sequence of commands:
terraform output config_map_aws_auth > configmap.yml
mv ./configmap.yml ~/.kube/configmap.yml
cd ~/.kube/
aws eks --region eu-central-1 update-kubeconfig --name mintos-eks --profile terraform > config
kubectl get nodes -o wide

4. Deploy Sonarqube and Nginx Helm charts in created kubernetes cluster.
Run the following sequence of commands.
cd ..
cd helm
terraform init
terraform plan
terrafrom apply -auto-approve
cd ..
cd ~/.kube
kubectl apply -f sonar-ingress.yaml

5. Check results. Run the following sequence of commands.
kubectl get pvc
kubectl get pods
kubectl get services sonarqube-sonarqube
kubectl get services nginxingress-nginx-ingress-controller 

As a result Sonarqube is running in EKS node along with postrgesql and nginx-ingress. You can access Sonarqube via nginxingress http://externalIP/sonarqube.