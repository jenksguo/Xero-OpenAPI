#!/bin/sh

SCRIPT="$0"
echo "# START SCRIPT: $SCRIPT"

./openapi-generator-check.sh || exit 1

# remote yaml on github "master"
ags="generate 
-t ../modules/ruby-client 
-i https://raw.githubusercontent.com/XeroAPI/Xero-OpenAPI/oauth2/accounting-yaml/Xero_accounting_2.0.0_swagger.yaml 
-g ruby 
-c ruby-oauth2-accounting.json 
-o  ../output/xero-ruby/accounting 
-D debugModels=false 
-DhideGenerationTimestamp=true  $@"

openapi-generator $ags

gem uninstall xero-ruby
cd ../output/xero-ruby/accounting/ && rake install
