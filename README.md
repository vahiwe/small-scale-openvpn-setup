# Small Scale OpenVPN Setup

This Infrastructure sets up an OpenVPN Server on AWS. For visiblity the infrastructure has been setup using [Terraform](https://www.terraform.io/). [Terragrunt](https://terragrunt.gruntwork.io/) is used in hand with the Terraform modules to keep the configurations DRY(DO NOT REPEAT YOURSELF).

## Setup

- [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Install Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Folder Structure

The folder structure is shown below:

```
.
├── deployments
│   ├── dns
│   ├── ec2
│   └── sshKeyPair
├── modules
│   ├── dns
│   ├── ec2
│   └── sshKeyPair
└── templates
```

The modules directory has all the terraform modules. 

The deployments folder has all the environment folders with the terragrunt files referencing the files in modules folder.

The templates folder has all the templates for the terraform modules.

## Configuration
The configuration for the infrastructure is done in the `config.yml` files.

Update the `config.yml` file in the `deployments/dns/config.yml` folder with the domain and subdomain name you want to use for the OpenVPN server.

Subscribe to the OPENVPN AMI from [here](https://aws.amazon.com/marketplace/pp/prodview-fiozs66safl5ae) and update the `config.yml` file in the `deployments/ec2/config.yml` folder with the AMI Alias.

## Deployment

Make sure you're signed in to the right AWS account for your deployment.

To deploy the infrastructure, run the following commands:-

```bash
$ cd terraform/deployments

$ terragrunt run-all validate

$ terragrunt run-all plan

$ terragrunt run-all apply
```

Documentation for the above commands can be found [here](https://terragrunt.gruntwork.io/docs/reference/cli-options/)

## Post Configuration
Once the infrastructure is deployed, you need to configure the OpenVPN server.

- SSH into the OpenVPN server using the SSH key pair created by the infrastructure. The SSH key pair is created in the `deployments/sshKeyPair` folder.

- You can refer to the [OpenVPN documentation](https://openvpn.net/vpn-server-resources/amazon-web-services-ec2-tiered-appliance-quick-start-guide/) to configure the OpenVPN server.

- Once the OpenVPN server is configured, you can run the script `scripts/ssl_setup.sh` on the OpenVPN server to generate a valid SSL certificate for the OpenVPN server. The script is created after terraform deployment.

## Destroying the Infrastructure
To destroy the infrastructure, run the following commands:-

```bash
$ cd terraform/deployments

$ terragrunt run-all destroy
```