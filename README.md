# nanoporeCoverageAnalysis

nanoporeCoverageAnalysis, workflow that generates coverage analysis files from input of nanopore fastq files, a wrapper of the workflow https://github.com/mike-molnar/nanopore-SV-analysis

## Overview

## Dependencies

* [nanopore_sv_analysis 20220505](https://gitlab.oicr.on.ca/ResearchIT/modulator/-/blob/master/code/gsi/70_nanopore_sv_analysis.yaml)


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
`samplefile`|String|sample file
`smkConfig.generateConfig_modules`|String|modules needed to run generateConfig
`coverageAnalysis.modules`|String|Names and versions of modules


#### Optional workflow parameters:
Parameter|Value|Default|Description
---|---|---|---


#### Optional task parameters:
Parameter|Value|Default|Description
---|---|---|---
`smkConfig.generateConfig.jobMemory`|Int|8|memory allocated for Job
`smkConfig.generateConfig.timeout`|Int|24|Timeout in hours, needed to override imposed limits
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
`plotLarg`|File|output from rule run_coverage_analysis of the original workflow
`plotDepthChrms`|Array[File]|output from rule run_coverage_analysis of the original workflow

