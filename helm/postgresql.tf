#Postgersql, since mysql not supportedin latest versions
resource "helm_release" "postgres" {
  name  = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "postgresql"
  wait = false

  set {
    name  = "postgresqlPostgresPassword" 
    value = "verysecurepassword"
  }
  set {
    name  = "postgresqlUsername"
    value = "coolusername"
  }
  set {
    name  = "postgresqlPassword"
    value = "anothersecurepassword"
  }
  set {
    name  = "postgresqlDatabase"
    value = "mintos"
  }
}