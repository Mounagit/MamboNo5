
# creation du security group

resource "azurerm_network_security_group" "NSG_master" {
    name = "NSG_master"
    location = "${var.location}"
    resource_group_name = "${azurerm_resource_group.resource_group_project.name}"
    
    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

    }

    security_rule {

        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

    }


    security_rule {

        name                       = "HTTPS"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

    }

    security_rule {

        name                       = "jenkins"
        priority                   = 1004
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
        
    }

}

# création du subnet 
resource "azurerm_subnet" "subnet_master" {
    name = "subnet_master"
    resource_group_name = "${azurerm_resource_group.resource_group_project.name}"
    virtual_network_name = "${azurerm_virtual_network.AzureVnet.name}"
    address_prefix = "10.0.1.0/24"
}

# creation d'une adresse IP Public

resource "azurerm_public_ip" "IP_master" {
    name                         = "IP_master"
    location                     = "${var.location}"
    resource_group_name          = "${azurerm_resource_group.resource_group_project.name}"
    allocation_method            = "Static"
    
}

# création d'une carte reseau   

resource "azurerm_network_interface" "NIC_master" {
    name                      = "NIC_master"
    location                  = "${var.location}"
    resource_group_name       = "${azurerm_resource_group.resource_group_project.name}"
    network_security_group_id = "${azurerm_network_security_group.NSG_master.id}"   

    ip_configuration {
        name                          = "IPconfmaster"
        subnet_id                     = "${azurerm_subnet.subnet_master.id}"
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.1.5"
        public_ip_address_id          = "${azurerm_public_ip.IP_master.id}"
    }

}

# création d'une VM

resource "azurerm_virtual_machine" "Master" {

        name                  = "VMmaster"
        location              = "${var.location}"
        resource_group_name   = "${azurerm_resource_group.resource_group_project.name}"
        network_interface_ids = ["${azurerm_network_interface.NIC_master.id}"]
        vm_size               = "Standard_B1ms"

        storage_os_disk {
            name              = "myOsDisk1"
            caching           = "ReadWrite"
            create_option     = "FromImage"
            managed_disk_type = "Standard_LRS"

    }
        storage_image_reference {
            publisher = "OpenLogic"
            offer     = "CentOS"
            sku       = "7.6"
            version   = "latest"

        }
        
        os_profile {
            computer_name  = "MounaSylvainVM1"
            admin_username = "MounaSylvain"
        }

        os_profile_linux_config {
            disable_password_authentication = true
            ssh_keys {
                path     = "/home/MounaSylvain/.ssh/authorized_keys"
                key_data = "${var.key_data}"

        }

    }
}