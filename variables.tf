variable "aws_region" { default = "eu-central-1"} 
#variable "aws_access_key" { default = ""} #Define AWS access key if running this project locally
#variable "aws_secret_key" { default = ""} #Define AWS secret key if running this project locally
variable "cluster-name" { default = "mintos-eks" }
variable "kubernetes-version" { default = "1.18" }
variable "desired_number_nodes" { default = "1" }
variable "max_number_nodes"  { default = "2" }
variable "min_number_nodes" { default = "1" }