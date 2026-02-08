# Terraform Study Plan

A phased study plan for learning Terraform, based on the [One-Day Terraform Preparation Plan](one-day-terraform-preparation-plan.md).

---

## Phase 1: Setup & Foundations

**Goal:** Install tools, understand core concepts (providers, resources, variables), run first Terraform commands.

**Topics:**
- Install Terraform and AWS CLI
- Understand `.terraform` directory and `terraform init`
- Providers: `provider` block, `required_providers`
- Resources: `resource` block, meta-arguments (`count`, `for_each`, `depends_on`, `lifecycle`)
- Variables: `variable` block, passing values (`-var`, `.tfvars`, `TF_VAR_*`)
- Outputs: `output` block, exposing values

**Practice:**
- [ ] Install Terraform via Homebrew, verify with `terraform version`
- [ ] Configure AWS CLI (`aws configure`), verify with `aws sts get-caller-identity`
- [ ] Create `main.tf` with AWS provider, run `terraform init`
- [ ] Create a simple resource (`random_pet` or `null_resource`), experiment with `count`
- [ ] Declare variables, pass via `-var` and `.tfvars`
- [ ] Add outputs, observe after `terraform apply`

**Deliverable:** Working Terraform project with provider, resources, variables, and outputs.

---

## Phase 2: CLI Commands & HCL Syntax

**Goal:** Master core CLI workflow and HCL data structures.

**Topics:**
- `terraform plan` (including `-out`, `-destroy`, `-refresh-only`)
- `terraform apply` (including `-auto-approve`)
- `terraform destroy`
- `terraform fmt` and `terraform validate`
- Maps, lists, element access
- Conditional expressions and functions (`coalesce`, `join`, `length`)
- Local values (`locals { ... }`)

**Practice:**
- [ ] Run full plan/apply/destroy cycle
- [ ] Save plan to file, apply from file
- [ ] Use `-auto-approve` flag
- [ ] Declare maps and lists, access elements
- [ ] Write conditional expressions
- [ ] Use `locals` for computed helper values

**Deliverable:** Cheat sheet of commands and flags; configurations demonstrating HCL features.

---

## Phase 3: Modules & State

**Goal:** Understand modules for code reuse and state management basics.

**Topics:**
- Root module vs child modules
- `module` block, passing variables, reading outputs
- Module sources (local, Git, Registry)
- Module versioning
- `terraform.tfstate` file and how state works
- State drift from manual changes
- Backends: local vs remote (S3 + DynamoDB, HCP Terraform)

**Practice:**
- [ ] Extract existing resource into a child module under `modules/`
- [ ] Call the module from root, pass variables, read outputs
- [ ] Inspect `terraform.tfstate` to understand state structure
- [ ] (Optional) Configure a remote backend

**Deliverable:** Project restructured with at least one reusable module.

---

## Phase 4: Real AWS Infrastructure

**Goal:** Apply knowledge to provision actual AWS resources relevant to the Climatise stack.

**Topics:**
- S3 buckets
- EC2 instances
- Lambda functions
- RDS / DynamoDB
- SNS / SQS
- IAM roles and policies

**Practice:**
- [ ] Create an S3 bucket with Terraform (done in issue #1)
- [ ] Provision a Lambda function with an IAM role
- [ ] Create a DynamoDB table
- [ ] Set up an SQS queue
- [ ] Wire resources together (e.g., Lambda triggered by SQS)
- [ ] Destroy all resources after verification

**Deliverable:** Multi-resource Terraform project covering key AWS services.

---

## Phase 5: Review & Assessment Prep

**Goal:** Consolidate knowledge, fill gaps, prepare for assessment.

**Topics:**
- Advanced `plan`/`apply` options (`-replace`, `-target`)
- Terraform quizzes and practice tests
- SQL practice questions
- Python algorithm questions (e.g., peak-counting)
- GraphQL basics

**Practice:**
- [ ] Create a comprehensive command cheat sheet
- [ ] Take online Terraform quizzes
- [ ] Solve SQL practice problems
- [ ] Solve Python algorithm problems
- [ ] Review GraphQL fundamentals
- [ ] Go through official Terraform Getting Started tutorial

**Deliverable:** Confidence across all assessment sections (Terraform, SQL, Python, GraphQL).
