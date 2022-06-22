# nanoporeCoverageAnalysis

nanoporeCoverageAnalysis, workflow that generates coverage analysis files from input of nanopore fastq files, a wrapper of the workflow https://github.com/mike-molnar/nanopore-SV-analysis

## Overview

## Dependencies

* [nanopore_sv_analysis 20220505](https://gitlab.oicr.on.ca/ResearchIT/modulator/-/blob/master/code/gsi/70_nanopore_sv_analysis.yaml)
* [hg38-nanopore-sv-reference](https://gitlab.oicr.on.ca/ResearchIT/modulator/-/blob/master/data/gsi/50_hg38_nanopore_sv_reference.yaml)


## Usage

### Cromwell
```
java -jar cromwell.jar run nanoporeCoverageAnalysis.wdl --inputs inputs.json
```

### Inputs

#### Required workflow parameters:
Parameter|Value|Description
---|---|---
`sample`|String|name of sample
`normal`|String|name of the normal sample
`tumor`|String|name of the tumor sample
`samplefile`|File|sample file
`coverageAnalysis.modules`|String|Names and versions of modules


#### Optional workflow parameters:
Parameter|Value|Default|Description
---|---|---|---


#### Optional task parameters:
Parameter|Value|Default|Description
---|---|---|---
`generateConfig.jobMemory`|Int|8|memory allocated for Job
`generateConfig.timeout`|Int|24|Timeout in hours, needed to override imposed limits
`coverageAnalysis.jobMemory`|Int|32|memory allocated for Job
`coverageAnalysis.timeout`|Int|24|Timeout in hours, needed to override imposed limits


### Outputs

Output | Type | Description
---|---|---
`depth100window`|File|output from rule run_coverage_analysis of the original workflow
`depth1000window`|File|output from rule run_coverage_analysis of the original workflow
`depth10000window`|File|output from rule run_coverage_analysis of the original workflow
`depth100000window`|File|output from rule run_coverage_analysis of the original workflow
`depth500000window`|File|output from rule run_coverage_analysis of the original workflow
`plotDepth`|File|output from rule run_coverage_analysis of the original workflow
`plotSmall`|File|output from rule run_coverage_analysis of the original workflow
`plotLarge`|File|output from rule run_coverage_analysis of the original workflow
`plotDepthChrms`|Array[File]|output from rule run_coverage_analysis of the original workflow


## Support

For support, please file an issue on the [Github project](https://github.com/oicr-gsi) or send an email to gsi@oicr.on.ca .

_Generated with generate-markdown-readme (https://github.com/oicr-gsi/gsi-wdl-tools/)_
