resource "aws_efs_file_system" "factorio" {}

resource "aws_efs_mount_target" "factorio" {
  file_system_id = aws_efs_file_system.factorio.id
  subnet_id      = module.vpc.public_subnets[0]
  security_groups = [
    aws_security_group.efs.id
  ]
}

