<!-- markdownlint-disable -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 2.0 |
| local | >= 1.2 |
| null | >= 2.0 |
| template | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enabled | Set to `false` to prevent the module from creating and accessing any resources | `bool` | `true` | no |
| kms\_arn | The ARN of a KMS key used to encrypt and decrypt SecretString values | `string` | `""` | no |
| parameter\_read | List of parameters to read from SSM. These must already exist otherwise an error is returned. Can be used with `parameter_write` as long as the parameters are different. | `list(string)` | `[]` | no |
| parameter\_write | List of maps with the parameter values to write to SSM Parameter Store | `list(map(string))` | `[]` | no |
| split\_delimiter | A delimiter for splitting and joining lists together for normalising the output | `string` | `"~^~"` | no |
| tags | Map containing tags that will be added to the parameters | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn\_map | A map of the names and ARNs created |
| map | A map of the names and values created |
| names | A list of all of the parameter names |
| values | A list of all of the parameter values |

<!-- markdownlint-restore -->
