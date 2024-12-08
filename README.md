# eolas-graph

## UI

The graph is created using React with the local and production build managed
with [vite](https://vite.dev).

https://react.dev/learn/add-react-to-an-existing-project

### Development

#### Vite development server

Start the development server at `http://localhost:5173/`:

```sh
cd ui
npm run dev
```

This will run the application in a browser window as a standalone application.

#### Neuron development server

The graph is not deployed as a standalone application. It is embedded within a
static [Neuron](https://neuron.zettel.page) zettelkasten website as a widget.

To simulate and test the embedded version of the graph, there is a
`start_neuron_test_instance.sh` script which can be run with:

```
make test_neuron
```

This generates a minimal local instance of Neuron served from the `/test-neuron`
directory. It triggers the build process to generate a compiled JS bundle that is
imported by the index file of the Neuron test instance and launches this in
a browser window.

##### Pre-requisites

```
firefox
neuron
```

(Note: use the pre-compiled binary of Neuron on AUR (`neuron-zettelkasten-bin`) to avoid
installing via Nix.)

### Build

Run:

```
cd ui
npm run build
```

Vite will compile the React JavaScript and CSS into two files:

- `eolas-graph.js`
- `eolas-graph.css`

These files can then be imported in the Neuron file`head.html`. The graph application will run
within the Neuron `index.html` using `<div id="eolas-graph" /> as its entry-point.

## Infrastructure

The JS bundle and CSS for the React frontend and the graph data JSON are stored in an
AWS S3 bucket.

Provision of these resources is handled via Terraform and specified in
`/terraform/main.tf`.

To check provisions run `terraform apply` within that directory.

## Deployment

The scripts `/deploy/deploy_json.sh` and `/deploy/deploy_js.sh` respectively
upload the graph JSON and UI bundle to S3. In both cases this will automatically overwrite the previous versions.

The scripts expect the graph data to be at `/deploy/json/graph.json` and the graph
bundle to be at `/deploy/json/graph.js`.

Execute both via the Makefile command:

```
make deploy
```

Or just update the graph data:

```
make update-graph
```

### Sequence

1. Generate JS bundle using Vite in `ui`
2. Transfer build file to `deploy/js`

3. Generate graph JSON using `eolas-db` CLI
4. Transfer resulting JSON file to `deploy/json`

5. Upload JS to S3
6. Upload JSON to S3
