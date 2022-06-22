#!/bin/bash
set -euo pipefail

#enter the workflow's final output directory ($1)
cd $1

#find all bed  files, return their md5sums 
find  -name '*.bed' -xtype f -exec sh -c "cat {} | grep -v ^# | md5sum" \; |sort 
