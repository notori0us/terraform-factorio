data "aws_route53_zone" "selected" {
  name = var.domain
}

resource "aws_route53_record" "factorio" {

  zone_id = data.aws_route53_zone.selected.zone_id

  name = "${var.subdomain}.${data.aws_route53_zone.selected.name}"
  type = "A"
  ttl  = "300"

  # placeholder; managed by our dyndns app which will automatically populate this.
  records = ["10.0.0.1"]
  lifecycle {
    ignore_changes = [
      records
    ]
  }
}
