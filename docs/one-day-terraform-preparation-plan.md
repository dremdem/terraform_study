# One-Day Terraform Preparation Plan

## Introduction

To succeed in the technical assessment for a Backend/Cloud developer position at Climatise, you need to become comfortable with the basics of **Terraform** — an Infrastructure-as-Code tool. The fundamentals include the configuration structure, working with providers, variables, resources and modules, and key CLI commands. This schedule is designed for roughly 8-10 hours of intensive study and practice and aims to give you enough confidence to handle theoretical questions like `--auto-approve`.

### Study tips

- Find a quiet spot and take short breaks each hour to stay fresh.
- Create a separate practice project (for example, `~/terraform-practice`) so you can immediately try everything you read about.
- Perform tasks by hand — active practice leads to better retention.
- All links to the official documentation are included for quick access and reinforcement.

---

## Setup and Preparation (08:00-08:30)

### Install Terraform and prepare your environment

1. Download the latest Terraform release from HashiCorp (via `apt`, `brew` or by downloading a binary).
2. Create a working directory, for example `~/terraform-practice`, and `cd` into it.
3. Understand that Terraform keeps a hidden `.terraform` directory for plugins and state.
4. **Initialization (`terraform init`) is required before any operations** — it downloads providers and modules, creates or updates `.terraform` and is idempotent.
5. Run `terraform init` in an empty directory to see how the basic structure is created.

### Install AWS CLI (optional)

- If you plan to experiment with AWS resources, install and configure AWS CLI (`aws configure`) using a test account.
- For local experiments you can use providers like `random` or `null_resource` so you don't spend money.

---

## Terraform Basics (08:30-10:30)

### 1. Providers

- **Understand what a provider is:** Terraform uses provider plugins to interact with real cloud services or APIs. Providers define the available resource and data types. Plugins are distributed separately and hosted on the Terraform Registry.
- **The `provider` block:** this declaratively configures how Terraform connects to a service, specifying region, credentials and so on. Provider configuration should only appear in the root module — child modules inherit the configuration.
- **Declaring required providers:** inside the top-level `terraform` block you add a `required_providers` block specifying the source and version of the plugin. Then you configure the provider in the root module.
- **Practice:** create a `main.tf` file with a `terraform { required_providers {...} }` block and a `provider "aws"` (or `random` / `azurerm`), then run `terraform init` again — you'll see Terraform downloading the plugins.

### 2. Resources

- **The `resource` block:** represents a piece of infrastructure (an EC2 instance, S3 bucket, IAM role, etc.). The block has a resource type and name, and contains provider-specific arguments. Example:

```hcl
resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "private"
}
```

- **Meta-arguments:** resources have universal meta-arguments such as `count` (to create multiple instances), `for_each` (to create resources from a list or map), `depends_on` (to explicitly set dependencies) and `lifecycle` (for example `create_before_destroy`, `prevent_destroy`). These control lifecycle and creation order.
- **Practice:** create one or two resources (e.g., `random_pet` or `null_resource`) and experiment with `count` and `depends_on`.

### 3. Variables and Outputs

- **Input variables (`variable` block):** parameterize modules and configurations. Variables are declared in a module and values are passed via the CLI, variable files or environment variables. Arguments include `type` (data type), `default`, `description`, `validation` and `sensitive`. A variable without a `default` is required.
- **Passing values:** values can be supplied via `terraform apply -var='region=us-east-1'`, a `terraform.tfvars` file, environment variables (`TF_VAR_region`) or in HCP Terraform.
- **Practice:** declare a variable `bucket_name` of type `string` with a description. Pass it via `-var` and via a `.tfvars` file.
- **The `output` block:** returns values after applying a configuration. Outputs are like return values; they appear in CLI output, HCP Terraform UI, and allow you to pass information between modules or external tools. Example:

```hcl
output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.example.id
}
```

When calling a child module, output values expose attributes to the parent module, and root module outputs are shown after `apply`.

- **Practice:** add an `output` for the resource name and view the result after `terraform apply`.

### 4. Modules

- **What is a module:** a collection of configuration files in a folder. The folder you run Terraform from is the **root module**. Within it you can call **child modules** using the `module` block. Modules help you reuse code, standardize infrastructure and quickly provision repeating sets of resources.
- **Module sources:** local folders, Git repositories, S3 buckets, or Terraform Registry.
- **Practice:** move the S3 bucket definition into a separate folder as a module and call it from the root module:

```hcl
module "s3_bucket" {
  source      = "./modules/s3_bucket"
  bucket_name = "my-terraform-bucket"
}
```

---

## Terraform Commands (11:00-12:00)

Learn the primary CLI commands and experiment with them:

| Command | Purpose and key options |
|---------|----------------------|
| `terraform init` | Initializes the directory: downloads providers, prepares `.terraform` and can be re-initialized; run before any operations. |
| `terraform plan` | Creates an **execution plan**: reads the current state, compares it with the configuration and proposes a set of actions. This command does not change anything. Options include `-out=FILE`, `-destroy`, `-refresh-only`. |
| `terraform apply` | Executes a plan: creates/updates/destroys resources and updates the state. The `-auto-approve` option skips the confirmation prompt — useful for automation. |
| `terraform destroy` | Removes all objects managed by the configuration. Alias for `terraform apply -destroy`. |
| `terraform fmt` | Formats `.tf` files to a consistent style. |
| `terraform validate` | Checks the syntax and consistency of the configuration to catch errors early. |

### Practice

1. Create a simple resource (e.g., `random_pet`), then:
2. Run `terraform plan` and study the output.
3. Save the plan to a file (`-out=plan.out`), then apply it using `terraform apply plan.out`.
4. Try `terraform apply -auto-approve` to see that Terraform skips confirmation.
5. Run `terraform destroy` to remove resources; observe how `plan -destroy` creates a pre-destruction plan.

---

## Working with Strings, Variables and Conditionals (12:00-13:00)

- Practice declaring **maps and lists** and access elements (`var.list[0]`, `var.map["key"]`).
- Practice **conditional expressions** and functions (`coalesce`, `join`, `length`).
- Understand **local values** (`locals { ... }`), which let you define helper variables within a module.

---

## Lunch Break (13:00-14:00)

Take a proper break — have lunch or go for a walk.

---

## Modules and a Bit about State (14:00-15:30)

1. **Create your own modules.** Move configuration from the root module into a separate folder and call it via `module`. Practice passing variables into a module and reading output values. Use module versioning (e.g., Git tags).
2. **Learn about state:** Terraform stores state in a `terraform.tfstate` file. The state tracks what has been created and helps Terraform correctly plan changes. Understand that manual changes to infrastructure can lead to drift.
3. **Intro to backends:** a local backend stores state on disk; a remote backend (e.g., S3 + DynamoDB, or HCP Terraform) stores state remotely, allowing team collaboration.

---

## Review Commands and Prep for Test Questions (15:30-16:30)

- Create a **cheat sheet** of commands and flags. Memorize the `--auto-approve` flag. Review flags like `-destroy`, `-refresh-only`, `-out`.
- Familiarize yourself with other useful `plan` and `apply` options, like `-replace` (replace a resource) and `-target` (focus on a specific resource).
- Take some online Terraform quizzes (search for *Terraform CLI quiz*).
- Write a couple of small configurations for different scenarios: creating an S3 bucket, an EC2 instance, a Lambda function (if you know AWS) or local resources.
- If time allows, go through the official Terraform Getting Started tutorial.

---

## Final Review and Notes (16:30-17:00)

- Summarize what commands you used and which concepts were challenging.
- Re-read the job requirements: **AWS (Lambda, RDS, DynamoDB, S3, SNS/SQS), Terraform, GraphQL** and consider which resources you, as a backend developer, will need to describe.
- Remember that the assessment also contains **SQL** and **Python algorithm** questions (e.g., the peak-counting problem). Plan to spend the evening practising SQL and algorithm problems.

---

## Additional Resources

### Official Terraform documentation

- [CLI initialization and working directories](https://developer.hashicorp.com/terraform/cli/init)
- [terraform plan command reference](https://developer.hashicorp.com/terraform/cli/commands/plan)
- [terraform apply command reference](https://developer.hashicorp.com/terraform/cli/commands/apply)
- [terraform destroy command reference](https://developer.hashicorp.com/terraform/cli/commands/destroy)
- [Providers - Configuration Language](https://developer.hashicorp.com/terraform/language/providers)
- [Provider block reference](https://developer.hashicorp.com/terraform/language/block/provider)
- [Provider Requirements](https://developer.hashicorp.com/terraform/language/providers/requirements)
- [Configure a resource](https://developer.hashicorp.com/terraform/language/resources/configure)
- [resource block reference](https://developer.hashicorp.com/terraform/language/block/resource)
- [variable block reference](https://developer.hashicorp.com/terraform/language/block/variable)
- [output block reference](https://developer.hashicorp.com/terraform/language/block/output)
- [Use outputs to expose module data](https://developer.hashicorp.com/terraform/language/values/outputs)
- [Modules overview](https://developer.hashicorp.com/terraform/language/modules)

### Other

- Watch short videos (e.g., "Terraform in 30 minutes") to visualise the process.
- Download a handy Terraform CLI cheat sheet (e.g. from spacelift.io or env0).
