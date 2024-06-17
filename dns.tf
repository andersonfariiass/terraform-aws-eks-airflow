##########################################################################################################
# Se o deploy for na conta PoC da Brlink esse bloco de codigo cria um DNS em uma zona existente da conta.#
##########################################################################################################

# resource "aws_route53_record" "www" {
#   zone_id = data.aws_route53_zone.selected.zone_id
#   name    = "brlink-poc-airflow.webc2aws.online"
#   type    = "CNAME"
#   ttl     = 300
#   records =  [data.aws_lb.load_balancer.dns_name]

#   depends_on = [ 
#     kubernetes_ingress_v1.airflow_ingress
#  ]
# }