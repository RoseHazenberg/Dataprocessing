"""
All the rules that use bcftools as command are in this file.
It also uses samtools to pileup.
#bcftools_view, create the pileup and convert into a .bcf file
"""

configfile: 'config/config.yaml'

rule bcftools:
    input:
        ref_gen = 'data/reference.fa',
        bam = expand('filtered/out{sample}.dedupe.bam', sample=config['samples']),
        bai = expand('filtered/out{sample}.dedupe.bam.bai', sample=config['samples'])
    output:
        'results/out.vcf'
    log:
        'logs/bcftools/bcf.log'
    benchmark:
        'benchmarks/out.vcf.benchmark.txt'
    threads: 2
    message: 'executing samtools mpileup on {input.ref_gen} {input.bam} and covert with bcftools view into {output} with {threads} threads'
    shell:
        '(samtools mpileup -uf {input.ref_gen} {input.bam} | '
        'bcftools view -> {output}) 2> {log}'