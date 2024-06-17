output "aws_account_id" {
  description = "Conta onde será feito deploy do terraform"
  value       = data.aws_caller_identity.current.account_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name}"
}

output "oidc_provider_arn" {
  description = "O ARN do provedor OIDC se enable_irsa = true"
  value       = module.eks.oidc_provider_arn
}

# output "certificate_arn" {
#   description = "ARN do certificado webc2aws.online conta PoC Brlink"
#   value       = data.aws_acm_certificate.issued.arn
# }

# Output para obter o DNS do Load Balancer associado ao Ingress
output "load_balancer_hostname" {
  description = "DNS/URL do Load Balancer usado para acessar o airflow"
  value       = kubernetes_ingress_v1.airflow_ingress.status.0.load_balancer.0.ingress.0.hostname
  depends_on  = [kubernetes_ingress_v1.airflow_ingress]
}