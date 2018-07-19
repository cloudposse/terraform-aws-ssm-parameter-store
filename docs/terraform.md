
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enabled | Set to `false` to prevent the module from creating and accessing any resources | string | `true` | no |
| kms_arn | The ARN of a KMS key used to encrypt and decrypt SecretString values | string | `` | no |
| parameter_read | List of parameters to read from SSM. These must already exist otherwise an error is returned. Can be used with `parameter_write` as long as the parameters are different. | list | `<list>` | no |
| parameter_write | List of maps with the Parameter values in this format.   Parameter Write Format Example<br><br>  [{     name = "/cp/prod/app/database/master_password" // Required     type = "SecureString" // Required - Valid types are String, StringList and SecureString     value = "password1" // Required     description = "Production database master password" // Optional     overwrite = false // Optional - Force Overwrite of value if true.    }] | list | `<list>` | no |
| split_delimiter | A delimiter for splitting and joining lists together for normalising the output | string | `~^~` | no |
| tags | Map containing tags that will be added to the parameters | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| map | A map of the names and values created |
| names | A list of all of the parameter names |
| values | A list of all of the parameter values |

