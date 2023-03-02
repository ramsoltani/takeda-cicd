#!/usr/bin/env python

from jinja2 import Environment, FileSystemLoader
import yaml
import argparse

# Define command line arguments
parser = argparse.ArgumentParser()
parser.add_argument('-i', '--inventory', required=True, help='Path to inventory file')
parser.add_argument('-t', '--template', required=True, help='Path to Jinja2 template file')
parser.add_argument('-o', '--output', required=True, help='Path to output file')
args = parser.parse_args()

# Load inventory data from YAML file
with open(args.inventory) as f:
    inventory = yaml.safe_load(f)

# Load Jinja2 template
env = Environment(loader=FileSystemLoader('.'))
template = env.get_template(args.template)

# Render template with inventory data
result = template.render(inventory)

# Write output to file
with open(args.output, 'w') as f:
    f.write(result)
