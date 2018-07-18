<!-- This file was automatically generated by the `build-harness`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

[![Cloud Posse](https://cloudposse.com/logo-300x69.svg)](https://cloudposse.com)

# terraform-aws-ssm-parameter-store [![Build Status](https://travis-ci.org/cloudposse/terraform-aws-ssm-parameter-store.svg?branch=master)](https://travis-ci.org/cloudposse/terraform-aws-ssm-parameter-store) [![Latest Release](https://img.shields.io/github/release/cloudposse/terraform-aws-ssm-parameter-store.svg)](https://github.com/cloudposse/terraform-aws-ssm-parameter-store/releases/latest) [![Slack Community](https://slack.cloudposse.com/badge.svg)](https://slack.cloudposse.com)


Terraform module for providing read and write access to the AWS SSM Parameter Store.


---

This project is part of our comprehensive ["SweetOps"](https://docs.cloudposse.com) approach towards DevOps. 


It's 100% Open Source and licensed under the [APACHE2](LICENSE).









## Introduction

* [AWS Details on what values can be used](https://docs.aws.amazon.com/systems-manager/latest/userguide/sysman-paramstore-su-create.html)
* [AWS API for PutParameter](https://docs.aws.amazon.com/systems-manager/latest/APIReference/API_PutParameter.html)
* [Terraform aws_ssm_parameter resource page](https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html)
* [Terraform aws_ssm_parameter data page](https://www.terraform.io/docs/providers/aws/d/ssm_parameter.html)





## Examples

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



## Makefile Targets
```
Available targets:

  help                                This help screen
  help/all                            Display help for all targets
  lint                                Lint terraform code

```

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




## Related Projects

Check out these related projects.

- [terraform-aws-ssm-iam-role](https://github.com/cloudposse/terraform-aws-ssm-iam-role) - Terraform module to provision an IAM role with configurable permissions to access SSM Parameter Store
- [terraform-aws-ssm-parameter-store-policy-documents](https://github.com/cloudposse/terraform-aws-ssm-parameter-store-policy-documents) - A Terraform module that generates JSON documents for access for common AWS SSM Parameter Store policies
- [terraform-aws-iam-chamber-user](https://github.com/cloudposse/terraform-aws-iam-chamber-user) - Terraform module to provision a basic IAM chamber user with access to SSM parameters and KMS key to decrypt secrets, suitable for CI/CD systems (e.g. TravisCI, CircleCI, CodeFresh) or systems which are external to AWS that cannot leverage AWS IAM Instance Profiles



## Help

**Got a question?**

File a GitHub [issue](https://github.com/cloudposse/terraform-aws-ssm-parameter-store/issues), send us an [email][email] or join our [Slack Community][slack].

## Commerical Support

Work directly with our team of DevOps experts via email, slack, and video conferencing. 

We provide *commercial support* for all of our [Open Source][github] projects. As a *Dedicated Support* customer, you have access to our team of subject matter experts at a fraction of the cost of a fulltime engineer. 

[![E-Mail](https://img.shields.io/badge/email-hello@cloudposse.com-blue.svg)](mailto:hello@cloudposse.com)

- **Questions.** We'll use a Shared Slack channel between your team and ours.
- **Troubleshooting.** We'll help you triage why things aren't working.
- **Code Reviews.** We'll review your Pull Requests and provide constructive feedback.
- **Bug Fixes.** We'll rapidly work to fix any bugs in our projects.
- **Build New Terraform Modules.** We'll develop original modules to provision infrastructure.
- **Cloud Architecture.** We'll assist with your cloud strategy and design.
- **Implementation.** We'll provide hands on support to implement our reference architectures. 


## Community Forum

Get access to our [Open Source Community Forum][slack] on Slack. It's **FREE** to join for everyone! Our "SweetOps" community is where you get to talk with others who share a similar vision for how to rollout and manage infrastructure. This is the best place to talk shop, ask questions, solicit feedback, and work together as a community to build *sweet* infrastructure.

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/cloudposse/terraform-aws-ssm-parameter-store/issues) to report any bugs or file feature requests.

### Developing

If you are interested in being a contributor and want to get involved in developing this project or [help out](https://github.com/orgs/cloudposse/projects/3) with our other projects, we would love to hear from you! Shoot us an [email](mailto:hello@cloudposse.com).

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!


## Copyright

Copyright © 2017-2018 [Cloud Posse, LLC](https://cloudposse.com)



## License 

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.









## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

This project is maintained and funded by [Cloud Posse, LLC][website]. Like it? Please let us know at <hello@cloudposse.com>

[![Cloud Posse](https://cloudposse.com/logo-300x69.svg)](https://cloudposse.com)

We're a [DevOps Professional Services][hire] company based in Los Angeles, CA. We love [Open Source Software](https://github.com/cloudposse/)!

We offer paid support on all of our projects.  

Check out [our other projects][github], [apply for a job][jobs], or [hire us][hire] to help with your cloud strategy and implementation.

  [docs]: https://docs.cloudposse.com/
  [website]: https://cloudposse.com/
  [github]: https://github.com/cloudposse/
  [jobs]: https://cloudposse.com/jobs/
  [hire]: https://cloudposse.com/contact/
  [slack]: https://slack.cloudposse.com/
  [linkedin]: https://www.linkedin.com/company/cloudposse
  [twitter]: https://twitter.com/cloudposse/
  [email]: mailto:hello@cloudposse.com


### Contributors

|  [![Erik Osterman][osterman_avatar]][osterman_homepage]<br/>[Erik Osterman][osterman_homepage] | [![Andriy Knysh][aknysh_avatar]][aknysh_homepage]<br/>[Andriy Knysh][aknysh_homepage] | [![Jamie Nelson][Jamie-BitFlight_avatar]][Jamie-BitFlight_homepage]<br/>[Jamie Nelson][Jamie-BitFlight_homepage] |
|---|---|---|

  [osterman_homepage]: https://github.com/osterman
  [osterman_avatar]: https://github.com/osterman.png?size=150
  [aknysh_homepage]: https://github.com/aknysh
  [aknysh_avatar]: https://github.com/aknysh.png?size=150
  [Jamie-BitFlight_homepage]: https://github.com/Jamie-BitFlight
  [Jamie-BitFlight_avatar]: https://github.com/Jamie-BitFlight.png?size=150


