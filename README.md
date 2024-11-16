# eolas-graph

## Infrastructure

The resulting transpiled JS file and the Eolas graph data JSON is stored in an
S3 bucket.

Provision of these resources is handled via Terraform and specified in
`/terraform/main.tf`.

To check provisions run `terraform apply` within that directory.
