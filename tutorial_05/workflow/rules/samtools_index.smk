"""
All the rules that use samtools as command are in this file that are used after markduplicates.
#samtools_index, index the results
"""

rule samtools_index:
    input:
        'filtered/out{sample}.dedupe.bam'
    output:
        'filtered/out{sample}.dedupe.bam.bai'
    benchmark:
        'benchmarks/{sample}.dedupe.bam.bai.benchmark.txt'
    threads: 2
    message: 'executing samtools index on {input} with {threads} threads'
    shell:
        'samtools index {input}'