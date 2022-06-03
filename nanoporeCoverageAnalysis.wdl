version 1.0
import "imports/pull_smkConfig.wdl" as smkConfig

workflow nanoporeCoverageAnalysis {
    input {
        String sample
        String normal
        String tumor
        File samplefile  
    }
    parameter_meta {
        sample: "name of sample"
        normal: "name of the normal sample"
        tumor: "name of the tumor sample"
        samplefile: "sample file"
    }

    call smkConfig.smkConfig{
        input:
        sample=sample,
        normal = normal,
        tumor = tumor,
        samplefile = samplefile    
    }

    call coverageAnalysis {
        input:
        config = smkConfig.config,
        sample = sample
    }

    output {
    File depth100window = coverageAnalysis.depth100window
    File depth1000window = coverageAnalysis.depth1000window
    File depth10000window = coverageAnalysis.depth10000window
    File depth100000window = coverageAnalysis.depth100000window
    File depth500000window = coverageAnalysis.depth500000window
    File plotDepth = coverageAnalysis.plotDepth
    File plotSmall = coverageAnalysis.plotSmall
    File plotLarge = coverageAnalysis.plotLarge
    Array[File] plotDepthChrms = coverageAnalysis.plotDepthChrms
        }

    meta {
     author: "Gavin Peng"
     email: "gpeng@oicr.on.ca"
     description: "nanoporeCoverageAnalysis, workflow that generates coverage analysis files from input of nanopore fastq files, a wrapper of the workflow https://github.com/mike-molnar/nanopore-SV-analysis"
     dependencies: [
      {
        name: "nanopore_sv_analysis/20220505",
        url: "https://gitlab.oicr.on.ca/ResearchIT/modulator/-/blob/master/code/gsi/70_nanopore_sv_analysis.yaml"
      }
     ]
     output_meta: {
        depth100window: "output from rule run_coverage_analysis of the original workflow",
        depth1000window: "output from rule run_coverage_analysis of the original workflow",
        depth10000window: "output from rule run_coverage_analysis of the original workflow",
        depth100000window: "output from rule run_coverage_analysis of the original workflow",
        depth500000window: "output from rule run_coverage_analysis of the original workflow",
        plotDepth: "output from rule run_coverage_analysis of the original workflow",
        plotSmall: "output from rule run_coverage_analysis of the original workflow",
        plotLarge: "output from rule run_coverage_analysis of the original workflow",
        plotDepthChrms: "output from rule run_coverage_analysis of the original workflow"
     }
    }
}

    # ==========================================================
    # run the nanopore workflow for coverage analysis
    # ==========================================================
    task coverageAnalysis {
        input {
        String sample
        File config    
        String modules
        Int jobMemory = 32
        Int timeout = 24
        }

        parameter_meta {
        jobMemory: "memory allocated for Job"
        modules: "Names and versions of modules"
        timeout: "Timeout in hours, needed to override imposed limits"
        }

        command <<<
        set -euo pipefail
        unset LD_LIBRARY_PATH
        cp $NANOPORE_SV_ANALYSIS_ROOT/Snakefile .
        cp ~{config} .
        $NANOPORE_SV_ANALYSIS_ROOT/bin/snakemake --jobs 16 --rerun-incomplete --keep-going --latency-wait 60 --cluster "qsub -cwd -V -o snakemake.output.log -e snakemake.error.log  -P gsi -pe smp {threads} -l h_vmem={params.memory_per_thread} -l h_rt={params.run_time} -b y "  run_coverage_analysis
        >>> 

    runtime {
    memory:  "~{jobMemory} GB"
    modules: "~{modules}"
    timeout: "~{timeout}"
    }

    output {
    File depth100window = "~{sample}/analysis/coverage/samtools_depth/~{sample}.depth.100_window.bed"
    File depth1000window = "~{sample}/analysis/coverage/samtools_depth/~{sample}.depth.1000_window.bed"
    File depth10000window = "~{sample}/analysis/coverage/samtools_depth/~{sample}.depth.10000_window.bed"
    File depth100000window = "~{sample}/analysis/coverage/samtools_depth/~{sample}.depth.100000_window.bed"
    File depth500000window  = "~{sample}/analysis/coverage/samtools_depth/~{sample}.depth.500000_window.bed"
    File plotDepth = "~{sample}/analysis/coverage/plots/~{sample}/~{sample}.depth.pdf"
    File plotSmall = "~{sample}/analysis/coverage/plots/~{sample}/~{sample}.small_chr.pdf"
    File plotLarge = "~{sample}/analysis/coverage/plots/~{sample}/~{sample}.large_chr.pdf"
    Array[File] plotDepthChrms = glob("~{sample}/analysis/coverage/plots/~{sample}/~{sample}.depth.*.pdf")
    }
    }
