provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "existing" {
  name     = "DevOpsIAC"
  location = "Canada Central"
}
 
resource "azurerm_kubernetes_cluster" "example" {
  name                = "devansh-cluster"
  location            = azurerm_resource_group.existing.location
  resource_group_name = azurerm_resource_group.existing.name
  dns_prefix          = "canadacentral-cluster"
 
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    #orchestrator_version = "latest"
    enable_auto_scaling = true
    min_count = 1
    max_count = 3
  }
 
  identity {
    type = "SystemAssigned"
  }
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}