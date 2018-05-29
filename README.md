# terraform-aws-parameter-store

Terraform module for providing read and write access to the AWS SSM Parameter Store.

* [AWS Details on what values can be used](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-su-create.html)
* [AWS API for PutParameter](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_PutParameter.html)
* [Terraform aws_ssm_parameter resource page](https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html)
* [Terraform aws_ssm_parameter data page](https://www.terraform.io/docs/providers/aws/d/ssm_parameter.html)

### Simple Write Parameter Example
```hcl
module "store_write" {
  source = "./terraform-aws-parameter-store"
  parameter_write = [{
  name = "/production/test/master/company"
  value = "Amazon"
  type = "String"
  overwrite = "true"
  description = "Company name"
  }]

  tags = {
  	ManagedBy = "Terraform"
  }
}
```
This example creates a new `String` parameter called `/production/test/master/company` with the value of `Amazon`

### Simple Read Parameter Example
```hcl
module "store_read" {
  source = "./terraform-aws-parameter-store"
  parameter_read = ["/production/test/master/company"]
}
```
This example reads a value from the parameter store if it exists, with the name `/production/test/master/company`

### Additional complete working example with variations of how to use the module
In [/example](./example) directory

