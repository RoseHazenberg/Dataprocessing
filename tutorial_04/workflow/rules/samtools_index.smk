"""
All the rules that use samtools as command are in this file that are used after markduplicates.
#samtools_index, index the results
"""

rule samtools_index:
    input:
        'filtered/out{sample}.dedupe.bam'
    output:
        'filtered/out{sample}.dedupe.bam.bai'
    message: 'executing samtools index on {input}'
    shell:
        'samtools index {input}'