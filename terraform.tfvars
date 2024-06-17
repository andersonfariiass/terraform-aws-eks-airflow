### Cluster Variables

cluster_name    = "eks-airflow"
cluster_version = 1.29

### Bucket Variables
bucket_name     = "dags-airflow"

### Tags
cluster_tags = {
  PoC       = "EKS Airflow",
  Descricao = "Cluster para PoC Apache Airflow"
}

tags = {
  PoC       = "EKS Airflow",
  Descricao = "PoC EKS + Apache Airflow"
}