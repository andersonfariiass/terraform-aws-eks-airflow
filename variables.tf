################################################################################
# Cluster
################################################################################

variable "cluster_name" {
  description = "Nome do cluster EKS"
  type        = string
}

variable "cluster_version" {
  description = "Versão '<major>.<minor>' do Kubernetes a ser usada para o cluster EKS (Ex: '1.27')"
  type        = string
}

# variable "control_plane_subnet_ids" {
#   description = "Lista de IDs de subnets onde o control plane do cluster (ENIs) EKS será provisionado. Usado para expandir o conjunto de subnets usadas por nodes/node group sem substituir o plano de controle EKS"
#   type        = list(string)
# }

# variable "node_groups_subnet_ids" {
#   description = "Lista de IDs de subnets onde os nodes/node group serão provisionados. Se 'control_plane_subnet_ids' não for fornecido, o plano de controle do cluster EKS (ENIs) será provisionado nessas subnets"
#   type        = list(string)
# }

variable "cluster_tags" {
  description = "Mapa de tags adicionais para adicionar ao cluster"
  type        = map(string)
  validation {
    condition     = try(var.cluster_tags.Name, "") == ""
    error_message = "Não colocar tag Name. Use a variavel cluster_name."
  }
  default = {}
}

variable "tags" {
  description = "Tags para todos os recursos do módulo"
  type        = map(any)
  validation {
    condition     = try(var.tags.Name, "") == ""
    error_message = "Não colocar tag Name. Use a variavel cluster_name."
  }
  default = null
}

variable "cluster_endpoint_private_access" {
  description = "Indica se o endpoint do servidor de API privado do Amazon EKS está habilitado ou não"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Indica se o endpoint do servidor de API pública do Amazon EKS está habilitado ou não"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "Lista de blocos CIDR que podem acessar o endpoint do servidor de API pública do Amazon EKS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_enabled_log_types" {
  description = "Lista dos logs do control plane desejados para habilitar. Valor default: 'audit', valores aceitos: 'api, audit, authenticator, controllerManager, scheduler'"
  type        = list(string)
  default     = ["audit"]
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "Chave KMS para criptografar os logs groups do cluster. Caso não tenha uma chave passar o valor 'null'"
  type        = string
  default     = null
}

################################################################################
# Cluster Security Group
################################################################################

# variable "vpc_id" {
#   description = "ID da VPC onde o  security group do cluster será provisionado"
#   type        = string
# }

################################################################################
# aws-auth configmap
################################################################################

variable "aws_auth_users" {
  description = "Lista de mapas de usuários para adicionar ao configmap do aws-auth"
  type        = list(any)
  default     = []
}

variable "aws_auth_roles" {
  description = "Lista de mapas de roles para adicionar ao configmap do aws-auth"
  type        = list(any)
  default     = []
}

variable "aws_auth_fargate_profile_pod_execution_role_arns" {
  description = "Lista de role ARNs Fargate profile pod execution para adicionar ao mapa de configuração do aws-auth"
  type        = list(string)
  default     = []
}

################################################################################
# IRSA
################################################################################

variable "enable_irsa" {
  description = "Determina se deve ser criado um OpenID Connect Provider para o cluster EKS ativar o IRSA"
  type        = bool
  default     = true
}

################################################################################
# Bucket
################################################################################
variable "bucket_name" {
  description = "Nome do Bucket para DAGS do Airflow"
  type        = string
}