## terraform-aws-ssm-parameter-store [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-ssm-parameter-store.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-ssm-parameter-store)

Terraform module for providing read and write access to the AWS SSM Parameter Store.

* [AWS Details on what values can be used](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-su-create.html)
* [AWS API for PutParameter](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_PutParameter.html)
* [Terraform aws_ssm_parameter resource page](https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html)
* [Terraform aws_ssm_parameter data page](https://www.terraform.io/docs/providers/aws/d/ssm_parameter.html)


## Usage

### Simple Write Parameter Example

This example creates a new `String` parameter called `/cp/prod/app/database/master_password` with the value of `password1`.

```hcl
module "store_write" {
  source          = "git::https://github.com/cloudposse/terraform-aws-ssm-parameter-store?ref=master"
  parameter_write = [{
  name            = "/cp/prod/app/database/master_password"
  value           = "password1"
  type            = "String"
  overwrite       = "true"
  description     = "Production database master password"
  }]

  tags = {
  	ManagedBy = "Terraform"
  }
}
```

### Simple Read Parameter Example

This example reads a value from the parameter store with the name `/cp/prod/app/database/master_password`

```hcl
module "store_read" {
  source         = "git::https://github.com/cloudposse/terraform-aws-ssm-parameter-store?ref=master"
  parameter_read = ["/cp/prod/app/database/master_password"]
}
```

### Additional Examples

The [`example`](./example) directory contains complete working examples with variations of how to use the module.


## Variables

|  Name              |  Default  |  Description                                                                     | Required        |
|:-------------------|:----------|:---------------------------------------------------------------------------------|:---------------:|
| parameter_read     | `[]`      | List of parameters to read from SSM                                              | Yes (for read)  |
| parameter_write    | `[]`      | List of maps with the Parameter values to write to SSM                           | Yes (for write) |
| tags               | `{}`      | Map containing tags that will be added to the parameters                         | No              |
| kms_arn            | ``        | The ARN of a KMS key used to encrypt and decrypt SecretString values             | No              |
| enabled            | `true`    | Set to `false` to prevent the module from creating and accessing any resources   | No              |


## Outputs

| Name       | Description                             |
|:-----------|:----------------------------------------|
| names      | A list of all of the parameter names    |
| values     | A list of all of the parameter values   |
| map        | A map of the names and values created   |


## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-ssm-parameter-store/issues), send us an [email](mailto:hello@cloudposse.com) or reach out to us on [Gitter](https://gitter.im/cloudposse/).


## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-ssm-parameter-store/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing `terraform-aws-ssm-parameter-store`, we would love to hear from you! 

Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

**NOTE:** Be sure to merge the latest from "upstream" before making a pull request!


## License

[APACHE 2.0](LICENSE) © 2018 [Cloud Posse, LLC](https://cloudposse.com)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.


## About

`terraform-aws-ssm-parameter-store` is maintained and funded by [Cloud Posse, LLC][website].

![Cloud Posse](https://cloudposse.com/logo-300x69.png)

Like it? Please let us know at <hello@cloudposse.com>

We love [Open Source Software](https://github.com/cloudposse/)!

See [our other projects][community]
or [hire us][hire] to help build your next cloud platform.

  [website]: https://cloudposse.com/
  [community]: https://github.com/cloudposse/
  [hire]: https://cloudposse.com/contact/


## Contributors

|[![Jamie Nelson][bitflight_img]][bitflight_web]<br/>[Jamie Nelson][bitflight_web] |[![Erik Osterman][erik_img]][erik_web]<br/>[Erik Osterman][erik_web] |[![Andriy Knysh][andriy_img]][andriy_web]<br/>[Andriy Knysh][andriy_web]  |
|---|---|---|

[bitflight_img]: https://avatars0.githubusercontent.com/u/25075504?s=144&u=ac7e53bda3706cb9d51907808574b6d342703b3e&v=4
[bitflight_web]: https://github.com/Jamie-BitFlight

[andriy_img]: https://avatars0.githubusercontent.com/u/7356997?v=4&u=ed9ce1c9151d552d985bdf5546772e14ef7ab617&s=144
[andriy_web]: https://github.com/aknysh/

[erik_img]: http://s.gravatar.com/avatar/88c480d4f73b813904e00a5695a454cb?s=144
[erik_web]: https://github.com/osterman/

