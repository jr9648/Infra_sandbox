# Create a security group for the frontend tier
resource "aws_security_group" "frontend_sg" {
  name        = "frontend-sg"
  description = "Security group for the frontend tier"

  # Ingress rules allow traffic from the internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access for administration (modify as needed)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["your_admin_IP/32"]
  }

  # Egress rules allow traffic to reach the backend tier
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_security_group.backend_sg.id]
  }
}

# Create a security group for the backend tier
resource "aws_security_group" "backend_sg" {
  name        = "backend-sg"
  description = "Security group for the backend tier"

  # Ingress rules allow traffic from the frontend and database tiers
  ingress {
    from_port   = 8080 # Adjust to your backend application port
    to_port     = 8080
    protocol    = "tcp"
    security_groups = [aws_security_group.frontend_sg.id, aws_security_group.database_sg.id]
  }
}

# Create a security group for the database tier
resource "aws_security_group" "database_sg" {
  name        = "database-sg"
  description = "Security group for the database tier"

  # Ingress rules allow traffic from the backend tier only
  ingress {
    from_port   = 3306 # Adjust to your database port (e.g., MySQL)
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.backend_sg.id]
  }
}

# Define output variables to get security group IDs
output "frontend_security_group_id" {
  value = aws_security_group.frontend_sg.id
}

output "backend_security_group_id" {
  value = aws_security_group.backend_sg.id
}

output "database_security_group_id" {
  value = aws_security_group.database_sg.id
}
