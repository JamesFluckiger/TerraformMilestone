location = "West US"
loc = "WUS"
env = "DevTest"
rg_name = "ace"
vnet_name = "ace"
vnet_address_space = [ "172.16.0.0/16" ]
vnet_dns_servers = [ "172.16.4.4","172.16.4.5" ]
snet_bastion_name = "AzureBastionSubnet"
snet_bastion_address_space = [ "172.16.0.128/25" ]
snet_adds_name = "adds"
snet_adds_address_space = [ "172.16.4.0/27"]
snet_web_name = "web"
snet_web_address_space = [ "172.16.1.0/24" ]
snet_gateway_address_space = [ "172.16.255.224/27" ]
nsg_name = "nsg-1"
lb_ip = "172.16.1.4"
vm_username = 
vm_password = "value"
web1_ip = "172.16.1.5"
web2_ip = "172.16.1.6"
dc1_ip = "172.16.4.4"
dc2_ip = "172.16.4.5"


