# FireGrid

Ignition deployment with Terraform and Ansible

## Configuration

When running `terraform`, the following variables will be asked for:

- `aws_ssh_key_name`
- `aws_private_key_user`
- `aws_private_key_file`
- `aws_access_key_id`
- `aws_access_key_secret`
- `safe_ssh_ip`: your WAN IP that is used to access the SSH service

You can create environment variables for them. This requires prefixing them with `TF_VAR_`.

Other settings such as the amount of workers to deploy can be found in `variables.tf`

## Deploying

Terraform basic commands:

- `terraform plan`
- `terraform apply`
- `terraform destroy`

To invalidate the Ansible provisioning, run `terraform taint null_resource.ansible-provisioning` before planning and applying the new configuration.

