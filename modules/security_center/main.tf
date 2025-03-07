resource "azurerm_security_center_subscription_pricing" "pricing" {
  tier = var.tier
}

output "pricing_tier" {
  value = azurerm_security_center_subscription_pricing.pricing.tier
}