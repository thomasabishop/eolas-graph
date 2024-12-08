#!/bin/bash

#============================================================================#
# FILE: bootstrap_neuron.sh																									 #
# USAGE: bootstrap_neuron.sh							  																 #
# DESCRIPTION: Add !																												 #
#============================================================================#

PROJECT_ROOT="/home/thomas/repos/eolas-graph"
FRONTEND_SOURCE="/ui/"
NEURON_TEST_DIR="/test-neuron"
NEURON_LOCAL_URL="http://127.0.0.1:8080"
NEURON_PORT=$(lsof -t -i:8080)

# TODO: Kill running local Neuron server if running
echo "INFO Terminating running local Neuron instance..."
sudo kill "$NEURON_PORT"

echo "INFO Purging stale frontend sourcefiles..."
cd "$PROJECT_ROOT$NEURON_TEST_DIR/static" || exit
rm eolas-graph.css
rm eolas-graph.js

echo "INFO Compiling frontend..."
cd "$PROJECT_ROOT$FRONTEND_SOURCE" || exit
npm run build

echo "INFO Copying frontend source files..."
cd "$PROJECT_ROOT" || exit
cp "$PROJECT_ROOT$FRONTEND_SOURCE/dist/eolas-graph.css" "$PROJECT_ROOT$NEURON_TEST_DIR/static/eolas-graph.css"
cp "$PROJECT_ROOT$FRONTEND_SOURCE/dist/eolas-graph.js" "$PROJECT_ROOT$NEURON_TEST_DIR/static/eolas-graph.js"

echo "INFO Starting Neuron server..."
cd "$PROJECT_ROOT$NEURON_TEST_DIR" || exit
(neuron gen -wS >/dev/null &)
sleep 2
firefox --new-window "$NEURON_LOCAL_URL"
