#Runs in loadbalancer mode
resource "helm_release" "nginx_ingress" {
  name       = "nginxingress"
  repository = "https://charts.helm.sh/stable"
  chart      = "nginx-ingress"
  wait = false
}