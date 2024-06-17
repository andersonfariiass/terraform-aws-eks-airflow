resource "kubernetes_namespace" "airflow" {
  metadata {
    name = "airflow"
  }
  # Marque como dependência para garantir que o namespace seja criado antes do Helm
  depends_on = [module.eks]
}