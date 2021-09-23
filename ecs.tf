resource "aws_ecs_cluster" "factorio" {
  name = "factorio"
}

resource "aws_ecs_service" "factorio" {
  cluster          = aws_ecs_cluster.factorio.id
  platform_version = "1.4.0"
  launch_type      = "FARGATE"
  name             = "factorio"
  task_definition  = aws_ecs_task_definition.factorio.arn
  desired_count    = 1

  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.factorio.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "factorio" {
  family                   = "factorio"
  task_role_arn            = aws_iam_role.factorio_task_role.arn
  execution_role_arn       = aws_iam_role.factorio_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "2048"
  memory = "4096"


  volume {
    name = "factorio-efs"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.factorio.id
      root_directory = "/"
    }
  }

  container_definitions = jsonencode([
    {
      cpu       = 0
      image     = var.image
      name      = "factorio-dedicated"
      essential = true

      mountPoints = [
        {
          sourceVolume  = "factorio-efs"
          containerPath = "/factorio"
          readOnly      = false
        }
      ]

      portMappings = [
        {
          containerPort = 34197
          hostPort      = 34197
          protocol      = "udp"
        },
        {
          containerPort = 27015
          hostPort      = 27015
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "REGION"
          value = data.aws_region.current.name
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.factorio.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "/aws/ecs"
        }
      }
    },

    {
      cpu       = 256
      memory    = 512
      image     = aws_ecr_repository.dyndns.repository_url
      name      = "dyndns"
      essential = true

      environment = [
        {
          name  = "AWS_REGION"
          value = data.aws_region.current.name
        },
        {
          name  = "HOSTED_ZONE_ID"
          value = data.aws_route53_zone.selected.zone_id
        },
        {
          name  = "DOMAIN"
          value = "factorio.${data.aws_route53_zone.selected.name}"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.factorio.name
          awslogs-region        = data.aws_region.current.name
          awslogs-stream-prefix = "/aws/ecs"
        }
      }

    }
  ])
}
