<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_route53_record.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [local_file.ssl_setup](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [aws_route53_zone.dns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The domain name of the hosted zone | `string` | n/a | yes |
| <a name="input_server_ip"></a> [server\_ip](#input\_server\_ip) | The IP address of the server | `string` | n/a | yes |
| <a name="input_source_root_dir"></a> [source\_root\_dir](#input\_source\_root\_dir) | The root directory of the source code | `string` | n/a | yes |
| <a name="input_subdomain"></a> [subdomain](#input\_subdomain) | The subdomain for the record | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_url"></a> [url](#output\_url) | The URL of the record |
<!-- END_TF_DOCS -->