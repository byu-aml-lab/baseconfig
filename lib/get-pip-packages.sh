#!/bin/bash
# Use pip to install requirements

packagesfile="$(dirname "$0")/requirements.txt"
python-pip install -r "$packagesfile"

