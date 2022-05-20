#!/bin/bash
set -euo pipefail

#enter the workflow's final output directory ($1)
cd $1

#find all fastq.gz files, return their md5sums to std out, list all file types
find ./analysis/coverage/samtools_depth/ -name *.bed -xtype f -exec sh -c "cat {} | grep -v ^# | md5sum" \;
find ./analysis/coverage/plots/ -name *.pdf -xtype f -exec sh -c "cat {} |md5sum" \;
ls ./analysis/coverage/samtools_depth | sed 's/.*\.//' | sort | uniq -c
