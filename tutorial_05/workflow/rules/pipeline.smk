SAMPLES = ['A', 'B']

rule all:
    input:
        'results/out.vcf'

rule bwa_index:
    input:
        'data/reference.fa'
    output:
        touch('results/bwa_index.done')
    threads: 8
    message: 'executing create bwa index in the genomic reference {input} to generate the following {output} with {threads} threads'
    shell:
        'bwa index {input}'

rule bwa_align:
    input:
        ref_gen = 'data/reference.fa',
        reads = 'data/{sample}.txt',
        check = 'results/bwa_index.done'
    output:
        'temp/out{sample}.sai'
    threads: 2
    message: 'executing bwa aln on {input.reads} against {input.ref_gen} to generate {output} with {threads} threads'
    shell:
        'bwa aln -I -t 8 {input.ref_gen} {input.reads} > {output}'

rule align_into_sam:
    input:
        ref_gen = 'data/reference.fa',
        reads = 'data/{sample}.txt',
        sai = 'temp/out{sample}.sai'
    output:
        'aligned/out{sample}.sam'
    threads: 4
    message: 'convert alignment into {output} by executing bwa samse'
    shell:
        'bwa samse {input.ref_gen} {input.sai} {input.reads} > {output}'

rule samtools_sort:
    input:
        'aligned/out{sample}.sam'
    output:
        bam = 'temp/out{sample}.bam',
        sort = 'sorted/out{sample}.sorted.bam'
    threads: 8
    message: 'executing {input} into {output.bam} and samtools sort on the following {output.bam} to generate the following {output.sort}'
    shell:
        'samtools view -S -b {input} > {output.bam} | \
         samtools sort {output.bam} -o {output.sort}'

rule detect_and_remove_duplicates:
    input:
        'sorted/out{sample}.sorted.bam'
    output:
        'filtered/out{sample}.dedupe.bam'
    threads: 10
    message: 'executing detection and removal of duplicates on {input} to generate {output}'
    shell:
        'java -jar ../../picard/build/libs/picard.jar MarkDuplicates \
                            -MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 1000 \
                            -METRICS_FILE results/out.metrics \
                            -REMOVE_DUPLICATES true \
                            -ASSUME_SORTED true  \
                            -VALIDATION_STRINGENCY LENIENT \
                            -INPUT {input} \
                            -OUTPUT {output}'

rule samtools_index:
    input:
        'filtered/out{sample}.dedupe.bam'
    output:
        'filtered/out{sample}.dedupe.bam.bai'
    threads: 2
    message: 'executing samtools index on {input}'
    shell:
        'samtools index {input}'

rule bcftools_view:
    input:
        ref_gen = 'data/reference.fa',
        bam = expand('filtered/out{sample}.dedupe.bam', sample=SAMPLES),
        bai = expand('filtered/out{sample}.dedupe.bam.bai', sample=SAMPLES)
    output:
        'results/out.vcf'
    threads: 1
    message: 'executing samtools mpileup on {input.ref_gen} {input.bam} and covert with bcftools view into {output} '
    shell:
        'samtools mpileup -uf {input.ref_gen} {input.bam} | '
        'bcftools view -> {output}'