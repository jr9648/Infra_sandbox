variable "frontend_ami_id" {
  description = "The AMI ID for the frontend instance."
}

variable "backend_ami_id" {
  description = "The AMI ID for the backend instance."
}

variable "database_ami_id" {
  description = "The AMI ID for the database instance."
}

variable "frontend_instance_type" {
  description = "The EC2 instance type for the frontend instance."
  default     = "t2.micro"  # You can change the default instance type if needed.
}

variable "backend_instance_type" {
  description = "The EC2 instance type for the backend instance."
  default     = "t2.micro"  # You can change the default instance type if needed.
}

variable "database_instance_type" {
  description = "The EC2 instance type for the database instance."
  default     = "t2.micro"  # You can change the default instance type if needed.
}
