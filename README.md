# eolas-graph

## UI

The frontend of the graph is created using React, managed via Vite.

### Development

The following starts the development server at `http://localhost:5173/`

```sh
cd ui
npm run dev
```

## Infrastructure

The resulting JS bundle of the React frontend and the Eolas graph data JSON is stored in an
S3 bucket.

Provision of these resources is handled via Terraform and specified in
`/terraform/main.tf`.

To check provisions run `terraform apply` within that directory.
