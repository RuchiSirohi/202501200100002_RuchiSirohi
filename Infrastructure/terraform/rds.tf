# ==========================================
# RDS Subnet Group
# ==========================================

resource "aws_db_subnet_group" "cloudnotes_db_subnet_group" {
  name = "cloudnotes-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_db_subnet_1.id,
    aws_subnet.private_db_subnet_2.id
  ]

  tags = {
    Name = "cloudnotes-db-subnet-group"
  }
}

# ==========================================
# RDS MySQL Database
# ==========================================

resource "aws_db_instance" "cloudnotes_db" {
  identifier = "cloudnotes-db"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "cloudnotes"
  username = "cloudnotes_user"
  password = random_password.db_password.result

  port = 3306

  db_subnet_group_name = aws_db_subnet_group.cloudnotes_db_subnet_group.name

  vpc_security_group_ids = [
    aws_security_group.db_sg.id
  ]

  publicly_accessible = false

  multi_az = true

  backup_retention_period = 1

  skip_final_snapshot = true

  deletion_protection = false

  tags = {
    Name = "cloudnotes-rds"
  }
}