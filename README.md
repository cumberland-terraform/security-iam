# Enterprise Terraform 
## AWS Core Compute
### EKS Authentication

Documentation goes here.

### Usage

```
module "mymodule" {
	source          = "ssh://git@source.mdthink.maryland.gov:22/et/mdt-eter-aws-core-compute-eks-auth.git"
	
	# TODO: vars go here

}
```

## Dependencies

### Internal

TODO

The ``mdt-eter-core-compute-eks`` module calls the following modules internally:

- ``mdt-eter-core-security-sg``

### External

TODO

The ``mdt-eter-core-compute-eks`` module requires the following required inputs:

- Worker Node IAM Role, ingested through `eks_config.worker_node.role_name`.

## Contributing

### Development

Checkout master and pull the latest commits,

```bash
git checkout master
git pull
```

Append ``feature/`` to all new branches.

```bash
git checkout -b feature/newthing
```

(Future State) 
Jenkins will run on PR requests from ``feature/*`` to ``master``. 
NOTE: we could turn on SCM polling to accomplish this, but would be expensive.
(Future State)

### Pull Request Checklist

- [] Update Changelog
- [] Open PR into ``master`` branch
- [] Ensure tests are passing in Jenkins
- [] Get approval from lead
- [] Tag latest commit with new version
- [] Publish version to Confluence

### Versioning

TODO
