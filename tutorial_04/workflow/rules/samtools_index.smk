rule samtools_index:
    input:
        'filtered/out{sample}.dedupe.bam'
    output:
        'filtered/out{sample}.dedupe.bam.bai'
    message: 'executing samtools index on {input}'
    shell:
        'samtools index {input}'