#!/bin/bash

set -ex

docs_dir="/home/user0/projects/projects_home/blackberry/bold/dev/tools/Research In Motion/BlackBerry JDE 5.0.0/docs/api"
entrypoint="index.html"

## ls "$docs_dir"
tree -L 1 "$docs_dir"

echo "http://localhost:9700/index.html"
python3 -m http.server -d "$docs_dir" 9700

