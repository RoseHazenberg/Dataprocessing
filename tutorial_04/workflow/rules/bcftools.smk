SAMPLES = ['A', 'B']

rule bcftools:
    input:
        ref_gen = 'data/reference.fa',
        bam = expand('filtered/out{sample}.dedupe.bam', sample=SAMPLES),
        bai = expand('filtered/out{sample}.dedupe.bam.bai', sample=SAMPLES)
    output:
        'results/out.vcf'
    message: 'executing samtools mpileup on {input.ref_gen} {input.bam} and covert with bcftools view into {output} '
    shell:
        'samtools mpileup -uf {input.ref_gen} {input.bam} | '
        'bcftools view -> {output}'