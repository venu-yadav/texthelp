# ECS Cluster definition
resource "aws_ecs_cluster" "webapp" {
  name = var.cluster_name
}

# ECS Task Definition for the Node.js app
resource "aws_ecs_task_definition" "nodejs_app" {
  family                   = "nodejs-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256" # Best practice: Right-size resources
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "nodejs-container",
      image = "node:latest", # Use a tag management strategy for container images
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "/ecs/nodejs-app"
          awslogs-region        = var.region
          awslogs-stream-prefix = "nodejs"
        }
      }
    }
  ])
}

# ECS Service for the app
resource "aws_ecs_service" "nodejs_app" {
  cluster        = aws_ecs_cluster.webapp.id
  task_definition = aws_ecs_task_definition.nodejs_app.arn
  desired_count  = 2 # Auto-scale based on actual load
  launch_type    = "FARGATE"

  network_configuration {
    subnets         = var.public_subnets
    security_groups = [aws_security_group.ecs.id] # Secure using SG
  }
}
