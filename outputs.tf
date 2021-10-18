# Splitting and joining, and then compacting a list to get a normalised list
locals {
  name_list = compact(concat(keys(local.parameter_write), local.parameter_read))

  value_list = compact(
    concat(
      [for p in aws_ssm_parameter.default : p.value], data.aws_ssm_parameter.read.*.value
    )
  )

  arn_list = compact(
    concat(
      [for p in aws_ssm_parameter.default : p.arn], data.aws_ssm_parameter.read.*.arn
    )
  )
}

output "names" {
  # Names are not sensitive
  value       = local.name_list
  description = "A list of all of the parameter names"
}

output "values" {
  description = "A list of all of the parameter values"
  value       = local.value_list
  sensitive   = true
}

output "map" {
  description = "A map of the names and values created"
  value       = zipmap(local.name_list, local.value_list)
  sensitive   = true
}

output "arn_map" {
  description = "A map of the names and ARNs created"
  value       = zipmap(local.name_list, local.arn_list)
}
