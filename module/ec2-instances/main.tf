resource "aws_key_pair" "ssh" {
  key_name   = "log-in-key"
  public_key = file("./module/public_key.pub")
}

resource "aws_instance" "frontend" {
  ami           = var.frontend_ami_id
  instance_type = var.frontend_instance_type  # Use the frontend instance type variable
  key_name      = aws_key_pair.ssh.key_name
  security_groups = [aws_security_group.frontend_backend_sg.name]
  tags = {
    Name = "frontend-instance"
    Layer = "frontend"
  }
  user_data = file("./module/frontend.sh")
}

resource "aws_instance" "backend" {
  ami           = var.backend_ami_id
  instance_type = var.backend_instance_type  # Use the backend instance type variable
  key_name      = aws_key_pair.ssh.key_name
  security_groups = [aws_security_group.frontend_backend_sg.name]
  tags = {
    Name = "backend-instance"
    Layer = "backend"
  }
  user_data = file("./module/backend.sh")
}

variable "ingressrules" {
    type = list(number)
    default = [80,443,22]
}

variable "egressrules" {
    type = list(number)
    default = [80,443,22]
}

resource "aws_security_group" "frontend_backend_sg" {
    name = "Allow HTTPS frontend and backend"

    dynamic "ingress" {
        iterator = port 
        for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        iterator = port 
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

resource "aws_instance" "database" {
  ami           = var.database_ami_id
  instance_type = var.database_instance_type  # Use the database instance type variable
  key_name      = aws_key_pair.ssh.key_name
  security_groups = [aws_security_group.database_sg.name]
  tags = {
    Name = "database-instance"
    Layer = "database"
  }
  user_data = file("./module/database.sh")
}

variable "ingressrules_database" {
    type = list(number)
    default = [80,443,22,19530,8000]
}

variable "egressrules_database" {
    type = list(number)
    default = [80,443,22,19530,8000]
}

resource "aws_security_group" "database_sg" {
    name = "Allow HTTPS database"

    dynamic "ingress" {
        iterator = port 
        for_each = var.ingressrules_database
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        iterator = port 
        for_each = var.egressrules_database
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}