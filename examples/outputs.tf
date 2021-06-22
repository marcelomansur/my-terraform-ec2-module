output "webserver_public_ip" {
  description = "EC2 instance public IP"
  value       = module.my_ec2.webserver_public_ip
}

output "webserver_private_ip" {
  description = "EC2 instance private IP"
  value       = module.my_ec2.webserver_private_ip
}

output "monitoring_private_ip" {
  description = "EC2 instance private IP"
  value       = module.my_ec2.monitoring_private_ip
}

output "database_private_ip" {
  description = "EC2 instance database IP"
  value       = module.my_ec2.database_private_ip
}
