output "kubectl-server-ip" {
  value = aws_instance.kubectl-server.public_ip
}

output "staging-server-ip" {
  value = aws_instance.staging-server.public_ip
}

output "kubectl-ssh-user" {
  value = local.kubectl_ssh_user
}

output "staging-ssh-user" {
  value = local.staging_ssh_user
}

