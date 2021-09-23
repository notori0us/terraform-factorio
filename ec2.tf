### quick hack to create an instance to access EFS
#resource "aws_instance" "efs" {
#  ami           = "ami-0c2d06d50ce30b442" # AL2
#  instance_type = "t3.micro"
#
#  availability_zone = "us-west-2a"
#
#  key_name = aws_key_pair.chris.key_name
#
#  subnet_id = module.vpc.public_subnets[0]
#
#  vpc_security_group_ids = [
#    aws_security_group.factorio.id,
#    aws_security_group.ssh.id
#  ]
#}
#
#resource "aws_key_pair" "chris" {
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC17a8EMKh7Lk3rgKLnW8XwKwG+UjXBPDPHfkweK/ZkBbrjAqSoBygpRYclziOeVg5JeqvWnPtU5pyAPwb+7S9yH+8Ygxihat1Gac+LKW+YOT6oVySTOT5x0GrhuJoH5cILQPx7IVrSA8quBXnEGgStkCR0a6LUAf2nIQ1+F1DfGrydsqY0uPs/aU3vpLLCCZryjoLLciB1+aBNY6kwuun1Prr9fXtUQB0/W3pKgJj67YiDTOVRitYEm6LDwJ4OWt5ntgiLiclzLmQABqtLMvT9e9f3jqY7FZxr3LecktFhEeofsIPS7B2TsD91zrMZGS5vAwPQgGNzQtvkNeyWZIecLleTqynMiBucuSh9vFHtIHqU1UNbOa4gabf/o4ktjiqvvbkZahWqOq1cCou+IckOYW6FbiRSI/sUZQ2cocKCadZYaP/vPOS7Y9gNt9nIv6K6sf0TDsuz2Up1cWzTwOBIQSJ0akDzOTMZgDwWXrODnxLR7RgC9Joi4ttebeB5Lr0= chris@Christophers-MacBook-Pro.local"
#}
#
#resource "aws_security_group" "ssh" {
#  name        = "ssh"
#  description = "allow ssh access"
#  vpc_id      = module.vpc.vpc_id
#
#  ingress {
#    description = "Allow incoming ssh"
#    from_port   = 22
#    to_port     = 22
#    protocol    = "tcp"
#    cidr_blocks = ["174.21.79.11/32"]
#  }
#
#  egress {
#    from_port        = 0
#    to_port          = 0
#    protocol         = "-1"
#    cidr_blocks      = ["0.0.0.0/0"]
#    ipv6_cidr_blocks = ["::/0"]
#  }
#}
