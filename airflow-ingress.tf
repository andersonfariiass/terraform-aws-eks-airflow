resource "kubernetes_ingress_v1" "airflow_ingress" {
  metadata {
    name      = "airflow-ingress"
    namespace = "airflow"
    annotations = {
      "alb.ingress.kubernetes.io/scheme"           = "internet-facing"
      "alb.ingress.kubernetes.io/target-type"      = "ip"
      "alb.ingress.kubernetes.io/healthcheck-path" = "/health"
      "alb.ingress.kubernetes.io/group.name"       = "airflow"
      "alb.ingress.kubernetes.io/listen-ports"     = "[{\"HTTP\":80}]"
      #"alb.ingress.kubernetes.io/listen-ports"                  = "[{\"HTTP\":80},{\"HTTPS\":443}]"
      #"alb.ingress.kubernetes.io/certificate-arn"               = data.aws_acm_certificate.issued.arn
      "alb.ingress.kubernetes.io/actions.ssl-external-redirect" = <<-EOT
        {
          "Type": "redirect",
          "RedirectConfig": {
            "Protocol": "HTTPS",
            "Port": "443",
            "Host": "#{host}",
            "Path": "/#{path}",
            "Query": "#{query}",
            "StatusCode": "HTTP_301"
          }
        }
      EOT
    }
  }
  spec {
    ingress_class_name = "alb"
    rule {
      #host = "meuhost.com.br"
      http {
        path {
          backend {
            service {
              name = "airflow-web"
              port {
                number = 8080
              }
            }
          }
          path = "/*"
        }
      }
    }
  }
  depends_on = [module.eks,
    kubernetes_namespace.airflow
  ]
}
