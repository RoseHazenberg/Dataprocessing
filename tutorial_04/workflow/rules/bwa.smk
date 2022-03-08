rule bwa_index:
    input:
        'data/reference.fa'
    output:
        touch('results/bwa_index.done')
    message: 'executing create bwa index in the genomic reference {input} to generate the following {output}'
    shell:
        'bwa index {input}'

rule bwa_align:
    input:
        ref_gen = 'data/reference.fa',
        reads = 'data/{sample}.txt',
        check = 'results/bwa_index.done'
    output:
        'temp/out{sample}.sai'
    message: 'executing bwa aln on {input.reads} against {input.ref_gen} to generate {output}'
    shell:
        'bwa aln -I -t 8 {input.ref_gen} {input.reads} > {output}'