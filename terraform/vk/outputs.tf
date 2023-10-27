# output "instance_fip-master-1" {
#     value = vkcs_networking_floatingip.fip-master-1.address
# }

# output "instance_fip-master-2" {
#     value = vkcs_networking_floatingip.fip-master-2.address
# }

# output "instance_fip-master-3" {
#     value = vkcs_networking_floatingip.fip-master-3.address
# }

output "instance_group_masters_public_ips" {
	description = "Public IP addresses for master nodes"
	value = vkcs_compute_instance.k8s-masters.*.network.0.fixed_ip_v4
}

output "instance_group_worker_public_ip" {
	description = "Public IP address for worker node"
	value = vkcs_compute_instance.k8s-worker.network.0.fixed_ip_v4
}

output "instance_group_haproxy_public_ip" {
	description = "Public IP address for HAproxy node"
	value = vkcs_compute_instance.k8s-haproxy.network.0.fixed_ip_v4
}

# output "instance_fip-worker-1" {
#     value = vkcs_networking_floatingip.fip-worker-1.address
# }
