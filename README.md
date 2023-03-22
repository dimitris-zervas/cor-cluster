# cor-cluster
A Kubernetes cluster running on Hetzner servers.

The purpose of this repo is to help you set up a simple K8S cluster in Hetzner servers. This is by no means to be used in Production.

# Prerequisites

* A Hetzner account
* An ssk-key uploaded in Hetzner console for your project.

Everything was developed on an OSx machine, with:

#### Terraform

```bash
Terraform v1.3.7
on darwin_amd64
+ provider registry.terraform.io/hashicorp/local v2.4.0
+ provider registry.terraform.io/hashicorp/null v3.2.1
+ provider registry.terraform.io/hetznercloud/hcloud v1.36.2
```

#### Ansible

```bash
ansible [core 2.14.3]
  config file = None
  configured module search path = ['/Users/mitsos/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/Cellar/ansible/7.3.0/libexec/lib/python3.11/site-packages/ansible
  ansible collection location = /Users/mitsos/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.11.2 (main, Feb 16 2023, 03:07:35) [Clang 14.0.0 (clang-1400.0.29.202)] (/usr/local/Cellar/ansible/7.3.0/libexec/bin/python3.11)
  jinja version = 3.1.2
  libyaml = True
```

# Give it a try

```bash
terraform init
terraform plan
terraform apply
```

