resource "helm_release" "airflow" {
  name          = "airflow"
  repository    = "https://airflow-helm.github.io/charts"
  chart         = "airflow"
  version       = "8.8.0"
  namespace     = "airflow"
  recreate_pods = false
  reuse_values  = true
  force_update  = true

  values = [file("./values-airflow.yaml")]

  depends_on = [module.eks]
}






