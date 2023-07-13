# Network

data "vkcs_networking_network" "extnet" {
    name = "ext-net"
}

resource "vkcs_networking_network" "k8s-network" {name = "k8s-network"}

resource "vkcs_networking_subnet" "k8s-subnet-1" {
	name       = "k8s-subnet-1"
	network_id = vkcs_networking_network.k8s-network.id
	cidr       = "192.168.10.0/24"
}

resource "vkcs_networking_subnet" "k8s-subnet-2" {
	name       = "k8s-subnet-2"
	network_id = vkcs_networking_network.k8s-network.id
	cidr       = "192.168.20.0/24"
}

resource "vkcs_networking_subnet" "k8s-subnet-3" {
	name = "k8s-subnet-3"
	network_id = vkcs_networking_network.k8s-network.id
	cidr       = "192.168.30.0/24"
}

resource "vkcs_networking_router" "k8s-router" {
    name                = "k8s-router"
    admin_state_up      = true
    external_network_id = data.vkcs_networking_network.extnet.id
}

resource "vkcs_networking_router_interface" "k8s-ri-1" {
    router_id = vkcs_networking_router.k8s-router.id
    subnet_id = vkcs_networking_subnet.k8s-subnet-1.id
}

resource "vkcs_networking_router_interface" "k8s-ri-2" {
    router_id = vkcs_networking_router.k8s-router.id
    subnet_id = vkcs_networking_subnet.k8s-subnet-2.id
}

resource "vkcs_networking_router_interface" "k8s-ri-3" {
    router_id = vkcs_networking_router.k8s-router.id
    subnet_id = vkcs_networking_subnet.k8s-subnet-3.id
}