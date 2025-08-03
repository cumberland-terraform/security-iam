# Enterprise Terraform 
## Cumberland Cloud Platform
## AWS Security - IAM

TODO

### Usage

The bare minimum deployment can be achieved with the following configuration,

**providers.tf**

```terraform
provider "aws" {
	region			        = "<region>"

	assume_role {
		role_arn                = "arn:aws:iam::<tenant-account>:role/<role-name>"
	}
}
```

**modules.tf**

```
module "iam" {
	source                  = "github.com/cumberland-terraform/security-iam"
	
	platform				= {
		aws_region          = "<region-name>"
        account             = "<account-name>"
        acct_env            = "<account-environment>"
        agency              = "<agency>"
        program             = "<program>"
		app					= "<application>"
        app_env             = "<application-environment>"
	}
	
    iam                     = {
        tags                = {
            owner           = "<owner>"
        }
    }

}
```

`platform` is a parameter for *all* **Cumberland Cloud** modules. For more information about the `platform`, in particular the permitted values of the nested fields, see the ``platform`` module documentation. 
