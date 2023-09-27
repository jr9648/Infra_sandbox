resource "aws_instance" "frontend" {
  ami           = var.frontend_ami_id
  instance_type = var.frontend_instance_type  # Use the frontend instance type variable
  tags = {
    Name = "frontend-instance"
    Layer = "frontend"
  }
  user_data = file("./module/frontend.sh")
}

resource "aws_instance" "backend" {
  ami           = var.backend_ami_id
  instance_type = var.backend_instance_type  # Use the backend instance type variable
  tags = {
    Name = "backend-instance"
    Layer = "backend"
  }
  user_data = file("./module/backend.sh")
}

resource "aws_instance" "database" {
  ami           = var.database_ami_id
  instance_type = var.database_instance_type  # Use the database instance type variable
  tags = {
    Name = "database-instance"
    Layer = "database"
  }
  user_data = file("./module/database.sh")
}
