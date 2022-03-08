rule align_into_sam:
    input:
        ref_gen = 'data/reference.fa',
        reads = 'data/{sample}.txt',
        sai = 'temp/out{sample}.sai'
    output:
        'aligned/out{sample}.sam'
    message: 'convert alignment into {output} by executing bwa samse'
    shell:
        'bwa samse {input.ref_gen} {input.sai} {input.reads} > {output}'

rule samtools_sort:
    input:
        'aligned/out{sample}.sam'
    output:
        bam = 'temp/out{sample}.bam',
        sort = 'sorted/out{sample}.sorted.bam'
    message: 'executing {input} into {output.bam} and samtools sort on the following {output.bam} to generate the following {output.sort}'
    shell:
        'samtools view -S -b {input} > {output.bam} | \
         samtools sort {output.bam} -o {output.sort}'