"""
All the rules that use bwa as command are in this file.
#bwa_index, creates BWA index in the genomic reference
#bwa_align, aligns the reads in the input file against the genomic reference
#align_into_sam, convert the alignment into .sam file
"""

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