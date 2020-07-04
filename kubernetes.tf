provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg_backend"
  location = "East US"
}

resource "azurerm_kubernetes_cluster" "kuber_cl" {
  name                = "kuber_lab_cl"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "kuberlab"

  default_node_pool {
    name       = "defaultpool"
    node_count = "1"
    vm_size    = "Standard_D2s_v3"
  }
 
 identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "dev"
  }
}


output "client_certificate" {
  value = azurerm_kubernetes_cluster.kuber_cl.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.kuber_cl.kube_config_raw
}

