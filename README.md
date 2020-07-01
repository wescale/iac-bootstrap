# iac-bootstrap

iac-bootstrap is a package to make fast deployments of infrastructure,  
on cloud providers, like AWS, with IAC tools like Ansible and Terraform.  

The full [documentation](https://iac-bootstrap.readthedocs.io/en/latest/) is available on Readthedocs.


## installation

To install the package.
```
pip install --user iac_bootstrap==1.0.3
```

There is a [quickstart](https://iac-bootstrap.readthedocs.io/en/latest/quickstart/) you should follow to build your own customized infrastructure.

If you want to test our example to get an idea of how it works, you can follow our simple usage, described below.


## Simple usage

iac-bootstrap automates terraform initialization and deployment, although generating necessary files for ansible and launch playbooks.  

You can use the available example, and define your own `group` and `env` values,  
or use the example with "mygroup" and "myenv" already available.

```
cd examples/infra-base
```

This generates the tfstate configuration
```
python -m iac_bootstrap.infra_bootstrap --account mygroup-myenv
```

This launches the terraform layers to build the infrastructure (vpc and autoscaling group)
```
python -m iac_bootstrap.infra_builder_terraform --account mygroup-myenv
```

This launches the ansible playbook to install nginx
```
python -m iac_bootstrap.install_nginx --group mygroup-myenv
```

.. Then you can destroy the infra when you have finished
```
python -m iac_bootstrap.infra_builder_terraform --account mygroup-myenv --action destroy
python -m iac_bootstrap.infra_bootstrap --account mygroup-myenv --action destroy
```


## Features

Here are features for infra_builder_terraform script:

```
Builder Terraform Script:
optional arguments:
  -h, --help            show this help message and exit
  --account ACCOUNT     account <group>-<env>
  --action ACTION       plan apply or destroy
  --region REGION       eu-west-1 by default
  --layer LAYER         terraform layer
  --ignore              ignore layer
  --provider PROVIDER   cloud provider , by default aws
  --approve APPROVE     Auto-approve option ,set 'yes' to enable it
```

Here are features for infra_bootstrap script :

```
Boot Strap script

optional arguments:
  -h, --help           show this help message and exit
  --provider PROVIDER  provider aws
  --account ACCOUNT    account <group>-<env>
  --action ACTION      plan apply or destroy
  --region REGION      eu-west-1 by default
  --approve APPROVE    Auto-approve option ,set 'yes' to enable it
```

## license

[GNU GENERAL PUBLIC LICENSE](https://github.com/WeScale/iac-bootstrap/blob/master/LICENSE)
