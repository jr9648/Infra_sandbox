resource "aws_key_pair" "ssh" {
  key_name   = "log-in-key"
  public_key = "${file("./scripts/public_key.pub")}"
}

output "ssh-key-name" {
  value = aws_key_pair.ssh.key_name
}