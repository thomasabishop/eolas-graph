DEPLOY_GRAPH_JS=./deploy/deploy_js.sh 
DEPLOY_GRAPH_JSON=./deploy/deploy_json.sh
BOOTSTRAP_NEURON=./scripts/start_neuron_test_instance.sh

.PHONY: deploy 

test_neuron:
	@bash ${BOOTSTRAP_NEURON} 

deploy:
	@echo "INFO Deploying to S3..."
	@bash ${DEPLOY_GRAPH_JSON} && ${DEPLOY_GRAPH_JS} || { echo "ERROR Make Deploy failed"; exit 1;}	

update-graph:
	@echo "INFO Updating graph data"
	@bash ${DEPLOY_GRAPH_JSON} || { echo "ERROR Graph data could not be updated"; exit 1;}	



