### Cluster Variables

cluster_name    = "eks-airflow"
cluster_version = 1.29
bucket_name     = "dags-airflow"

cluster_tags = {
  PoC       = "EKS Airflow",
  Descricao = "Cluster para PoC Apache Airflow"
}

tags = {
  PoC       = "EKS Airflow",
  Descricao = "PoC EKS + Apache Airflow"
}