output "webserver_public_ip" {
  description = "EC2 webserver instance public IP"
  value       = { for k, v in aws_instance.my_ec2_webserver_cluster : k => v.public_ip }
}

output "webserver_private_ip" {
  description = "EC2 webserver instance private IP"
  value       = { for k, v in aws_instance.my_ec2_webserver_cluster : k => v.private_ip }
}

output "monitoring_private_ip" {
  description = "EC2 monitoring instance private IP"
  value       = { for k, v in aws_instance.my_ec2_monitoring_cluster : k => v.private_ip }
}

output "database_private_ip" {
  description = "EC2 database instance database IP"
  value       = { for k, v in aws_instance.my_ec2_database_cluster : k => v.private_ip }
}
