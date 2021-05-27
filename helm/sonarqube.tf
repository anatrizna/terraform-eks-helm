resource "helm_release" "sonarqube" {
  name  = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart = "sonarqube"
  wait = false

  set {
    name  = "persistence.enabled" #Enable persistent storage
    value = "true"
  }
  set {
    name  = "replicaCount"
    value = "1"
  }
  set {
    name  = "postgresql.enabled" 
    value = "false"
  }
  set {
    name  = "mysql.enabled"
    value = "false"
  }
  set {
    name  = "database.type"
    value = "postgresql"
  }
  set {
    name  = "postgresql.postgresqlServer"
    value = "postgresql"
  }
  set {
    name  = "postgresql.postgresqlUsername" 
    value = "coolusername"
  }
  set {
    name  = "postgresql.postgresqlPassword"
    value = "anothersecurepassword"
  }
  set {
    name  = "postgresql.postgresqlDatabase"
    value = "mintos"
  }
}