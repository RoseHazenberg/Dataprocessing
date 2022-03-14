"""
Main script to be executed.
Includes all necessary Snakefiles needed
to execute the workflow.
"""

include: "bwa.smk"
include: "samtools.smk"
include: "markduplicates.smk"
include: "bcftools.smk"

rule all:
    input:
        'results/out.vcf'
