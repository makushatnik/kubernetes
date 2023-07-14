## Output values

output "instance_group_bastion_public_ip" {
  description = "Public IP address for Bastion Host"
  value       = yandex_compute_instance_group.bastion.network_interface.0.nat_ip_address
}

