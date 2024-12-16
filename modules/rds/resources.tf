resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  username             = var.username
  password             = var.password
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  # Security settings
  vpc_security_group_ids = [aws_security_group.rds.id]
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
}
