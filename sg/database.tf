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