"""
Main script to be executed.
Includes all necessary Snakefiles needed
to execute the workflow.
"""

configfile: 'config/config.yaml'
include: 'HTTP.smk'
include: 'NCBI.smk'
include: 'configuration.smk'

rule all:
    input:
        'results/test.txt',
        'results/test.fasta',
        'calls/merged_results.vcf'
