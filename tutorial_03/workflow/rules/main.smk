"""
Main script to be executed.
Includes all necessary Snakefiles needed
to execute the workflow.
"""

configfile: 'config/config.yaml'
include: 'HTTP.smk'
include: 'NCBI.smk'
include: 'configuration.smk'

rule all_files:
    input:
        'results/test.txt',
        'results/test.fasta',
        expand('data/{sample}.bam', sample=[x for x in config['samples']])
