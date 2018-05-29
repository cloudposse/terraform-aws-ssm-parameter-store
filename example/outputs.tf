output "parameter_names" {
  description = "List of key names"
  value       = "${module.store.names}"
}

output "parameter_values" {
  description = "List of values"
  value       = "${module.store.values}"
}

output "map" {
  description = "Map of parameters"
  value       = "${module.store.map}"
}
