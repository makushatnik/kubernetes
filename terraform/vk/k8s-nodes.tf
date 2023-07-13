# Compute instance group for control plane

data "vkcs_compute_flavor" "k8s-master-flavor" {
    name = "Standard-2-6"
}

data "vkcs_compute_flavor" "k8s-worker-flavor" {
    name = "Basic-1-2-40"
}

data "vkcs_images_image" "compute" {
    name = var.image_flavor
}

resource "vkcs_compute_instance" "k8s-masters" {
	count     = 3
	name      = "k8s-master-${count.index}"
    flavor_id = data.vkcs_compute_flavor.k8s-master-flavor.id
	security_groups   = ["default","ssh"]
    availability_zone = var.availability_zone_name

	block_device {
		uuid                  = data.vkcs_images_image.compute.id
		source_type           = "image"
		destination_type      = "volume"
		volume_type           = "network-ssd"
		volume_size           = 8
		boot_index            = 0
		delete_on_termination = true
    }

	network {
    	uuid = vkcs_networking_network.k8s-network.id
    }

	metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    depends_on = [
		vkcs_networking_network.k8s-network,
		vkcs_networking_subnet.k8s-subnet-1,
		vkcs_networking_subnet.k8s-subnet-2,
		vkcs_networking_subnet.k8s-subnet-3
    ]
}


# Compute instance group for workers
resource "vkcs_compute_instance" "k8s-worker" {
	name      = "k8s-worker"
    flavor_id = data.vkcs_compute_flavor.k8s-worker-flavor.id
	security_groups   = ["default","ssh"]
    availability_zone = var.availability_zone_name

	block_device {
		uuid                  = data.vkcs_images_image.compute.id
		source_type           = "image"
		destination_type      = "volume"
		volume_type           = "network-hdd"
		volume_size           = 4
		boot_index            = 0
		delete_on_termination = true
    }

	network {
    	uuid = vkcs_networking_network.k8s-network.id
    }

	metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    depends_on = [
		vkcs_networking_network.k8s-network,
		vkcs_networking_subnet.k8s-subnet-1,
		vkcs_networking_subnet.k8s-subnet-2,
		vkcs_networking_subnet.k8s-subnet-3
    ]
}

# Compute instance group for the LB
resource "vkcs_compute_instance" "k8s-haproxy" {
	name      = "k8s-haproxy"
    flavor_id = data.vkcs_compute_flavor.k8s-worker-flavor.id
	security_groups   = ["default","ssh"]
    availability_zone = var.availability_zone_name

	block_device {
		uuid                  = data.vkcs_images_image.compute.id
		source_type           = "image"
		destination_type      = "volume"
		volume_type           = "network-hdd"
		volume_size           = 4
		boot_index            = 0
		delete_on_termination = true
    }

	network {
    	uuid = vkcs_networking_network.k8s-network.id
    }

	metadata = {
        ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    depends_on = [
		vkcs_networking_network.k8s-network,
		vkcs_networking_subnet.k8s-subnet-1,
		vkcs_networking_subnet.k8s-subnet-2,
		vkcs_networking_subnet.k8s-subnet-3
    ]
}

# resource "vkcs_networking_floatingip" "fip-master-1" {
#     pool = data.vkcs_networking_network.extnet.name
# }

# resource "vkcs_compute_floatingip_associate" "fip-master-1" {
#     floating_ip = vkcs_networking_floatingip.fip-master-1.address
#     instance_id = vkcs_compute_instance.k8s-master-1.id
# }

# resource "vkcs_networking_floatingip" "fip-master-2" {
#     pool = data.vkcs_networking_network.extnet.name
# }

# resource "vkcs_compute_floatingip_associate" "fip-master-2" {
#     floating_ip = vkcs_networking_floatingip.fip-master-2.address
#     instance_id = vkcs_compute_instance.k8s-master-2.id
# }

# resource "vkcs_networking_floatingip" "fip-master-3" {
#     pool = data.vkcs_networking_network.extnet.name
# }

# resource "vkcs_compute_floatingip_associate" "fip-master-3" {
#     floating_ip = vkcs_networking_floatingip.fip-master-3.address
#     instance_id = vkcs_compute_instance.k8s-master-3.id
# }

# resource "vkcs_networking_floatingip" "fip-worker-1" {
#    pool = data.vkcs_networking_network.extnet.name
# }

# resource "vkcs_compute_floatingip_associate" "fip-worker-1" {
#    floating_ip = vkcs_networking_floatingip.fip-worker-1.address
#    instance_id = vkcs_compute_instance.k8s-worker.id
# }
