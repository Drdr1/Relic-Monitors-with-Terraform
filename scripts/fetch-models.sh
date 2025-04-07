#!/bin/bash
# Define the resource group
RESOURCE_GROUP="mosaic-rg"

# Initialize a temporary models.json
echo "[]" > models.json

# Fetch deployments for my-openai-1 and add API key credential name
az cognitiveservices account deployment list \
  --name "my-openai-1" \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].{ModelName:name, Endpoint:properties.endpoint}" -o json | \
  jq 'map(. + {ApiKeyCredential: "AZURE_OPENAI_API_KEY_1"})' | \
  jq -s '.[0] + .[1]' models.json - > temp.json && mv temp.json models.json

# Fetch deployments for my-openai-2 and add API key credential name
az cognitiveservices account deployment list \
  --name "my-openai-2" \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].{ModelName:name, Endpoint:properties.endpoint}" -o json | \
  jq 'map(. + {ApiKeyCredential: "AZURE_OPENAI_API_KEY_2"})' | \
  jq -s '.[0] + .[1]' models.json - > temp.json && mv temp.json models.json

# Convert to Terraform-compatible tfvars.json
jq -r '{ "models": . }' models.json > models.tfvars.json

echo "Model data written to models.tfvars.json"