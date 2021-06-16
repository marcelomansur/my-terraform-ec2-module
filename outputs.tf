output "webserver_public_ip" {
  description = "EC2 instance public IP"
  value       = module.my_ec2_webserver_cluster.public_ip
}

output "webserver_private_ip" {
  description = "EC2 instance private IP"
  value       = module.my_ec2_webserver_cluster.private_ip
}

output "monitoring_private_ip" {
  description = "EC2 instance private IP"
  value       = module.my_ec2_monitoring_cluster.private_ip
}

output "database_private_ip" {
  description = "EC2 instance database IP"
  value       = module.my_ec2_database_cluster.private_ip
}
