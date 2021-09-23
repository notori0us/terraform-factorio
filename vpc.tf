module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "factorio"
  cidr   = "10.0.0.0/16"

  azs                  = ["us-west-2a"]
  private_subnets      = []
  public_subnets       = ["10.0.0.0/22"]
  enable_nat_gateway   = false
  enable_dns_hostnames = true
}

resource "aws_security_group" "factorio" {
  name        = "factorio"
  description = "allow factorio server traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow incoming game traffic"
    from_port        = 34197
    to_port          = 34197
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "efs" {
  name        = "efs"
  description = "allow efs access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow EFS"
    from_port   = 2049
    to_port     = 2049
    protocol    = "TCP"
    security_groups = [
      aws_security_group.factorio.id
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

