SAMPLES = ['A', 'B', 'C']
workdir: '/mnt/c/Users/Rose Hazenberg/commons/data/'
FASTQ_DIR = 'samples/'

rule all:
    input:
        'calls/all.vcf'

rule bwa_map:
    input:
        'genome.fa',
        FASTQ_DIR + '{sample}.fastq'
    benchmark:
        'benchmarks/{sample}.bwa.benchmark.txt'
    output:
        'mapped_reads/{sample}.bam'
    message: 'executing bwa mem on the following {input} to generate the following {output}'
    shell:
        'bwa mem {input} | samtools view -Sb - > {output}'

rule samtools_sort:
    input:
        'mapped_reads/{sample}.bam'
    output:
        'sorted_reads/{sample}.bam'
    message: 'executing samtools sort on the following {input} to generate the following {output}'
    shell:
        'samtools sort -T sorted_reads/{wildcards.sample} '
        '-O bam {input} > {output}'

rule samtools_index:
    input:
        'sorted_reads/{sample}.bam'
    output:
        'sorted_reads/{sample}.bam.bai'
    message: 'executing samtools index on the following {input} to generate the following {output}'
    shell:
        'samtools index {input}'
        
rule bcftools_call:
    input:
        fa = 'genome.fa',
        bam = expand('sorted_reads/{sample}.bam', sample=SAMPLES),
        bai = expand('sorted_reads/{sample}.bam.bai', sample=SAMPLES)
    output:
        'calls/all.vcf'
    message: 'executing variant calling with samtools and bcftools combined'
    shell:
        'samtools mpileup -g -f {input.fa} {input.bam} | '
        'bcftools call -mv - > {output}'

rule report:
    input:
        'calls/all.vcf'
    output:
        'out.html'
    message: "executing report on all.vcf"
    run:
        from snakemake.utils import report
        with open(input[0]) as f:
            n_calls = sum(1 for line in f if not line.startswith('#'))

        report("""
        An example workflow
        ===================================
                    
        Reads were mapped to the Yeas reference genome
        and variants were called jointly with
        SAMtools/BCFtools.
                    
        This resulted in {n_calls} variants (see Table T1_).
        """, output[0], metadata = 'Author: Rose Hazenberg', T1 = input[0])
