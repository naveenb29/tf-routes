

variable "vpc_id" {
  description = "Peering connection to the avalanche VPC"
  default     = "pcx-***"
  type        = string
}


data "aws_route_tables" "route_tables_k8s" {
  vpc_id = "vpc-***"
}

resource "aws_route" "private_peering_connect" {
  count = length(data.aws_route_tables.route_tables_k8s.ids)

  route_table_id            = element(data.aws_route_tables.route_tables_k8s.ids[*], count.index)
  destination_cidr_block    = "10.0.0.0/22"
  vpc_peering_connection_id = var.vpc_peering_id

  timeouts {
    create = "5m"
  }
}
