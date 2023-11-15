## Output values

# output "instance_group_bastion_public_ip" {
#   description = "Public IP address for Bastion Host"
#   value       = yandex_compute_instance_group.bastion.network_interface.0.nat_ip_address
# }

# For future delete
output "instance_group_masters_public_ips" {
  description = "Public IP addresses for master-nodes"
  value       = yandex_compute_instance_group.k8s-masters.instances.*.network_interface.0.nat_ip_address
}

# For future delete
output "instance_group_workers_public_ips" {
  description = "Public IP addresses for worder-nodes"
  value       = yandex_compute_instance_group.k8s-workers.instances.*.network_interface.0.nat_ip_address
}

output "instance_group_haproxy_public_ips" {
  description = "Public IP addresses for haproxy-nodes"
  value       = yandex_compute_instance_group.k8s-haproxy.instances.*.network_interface.0.nat_ip_address
}

output "instance_group_haproxy_inner_ips" {
  description = "Inner IP addresses for haproxy-nodes"
  value       = yandex_compute_instance_group.k8s-haproxy.instances.*.network_interface.0.ip_address
}

output "instance_group_masters_inner_ips" {
  description = "Inner IP addresses for master-nodes"
  value       = yandex_compute_instance_group.k8s-masters.instances.*.network_interface.0.ip_address
}

output "instance_group_workers_inner_ips" {
  description = "Inner IP addresses for worder-nodes"
  value       = yandex_compute_instance_group.k8s-workers.instances.*.network_interface.0.ip_address
}