##################################################
# Output Variables
##################################################

# EC2 Public IP - used by Ansible inventory
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

# EC2 Instance ID (for tracking/debugging)
output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.web_server.id
}

# Security Group ID (useful reference for other infra)
output "security_group_id" {
  description = "ID of the Security Group associated with the web server"
  value       = aws_security_group.web_sg.id
}
