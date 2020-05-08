output "parameter_names" {
  description = "List of key names"
  value       = module.store.names
}

output "parameter_values" {
  description = "List of values"
  value       = module.store.values
}

output "map" {
  description = "A map of the names and values created"
  value       = module.store.map
}

output "arn_map" {
  description = "A map of the names and ARNs created"
  value       = module.store.arn_map
}
