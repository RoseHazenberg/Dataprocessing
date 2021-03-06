"""
All the rules that use samtools as command are in this file.
#samtools_sort, convert the .sam file into a .bam file and sort it
#samtools_index, index the results
"""

rule samtools_sort:
    input:
        'aligned/out{sample}.sam'
    output:
        bam = 'temp/out{sample}.bam',
        sort = 'sorted/out{sample}.sorted.bam'
    log:
        'logs/samtools/{sample}.log'
    benchmark:
        #Generates one file for both bam and sort
        'benchmarks/{sample}.bam.benchmark.txt'
    threads: 4
    message: 'executing {input} into {output.bam} and samtools sort on the following {output.bam} to generate the following {output.sort} with {threads} threads'
    shell:
        '(samtools view -S -b {input} > {output.bam} | '
        'samtools sort {output.bam} -o {output.sort}) 2> {log}'

rule samtools_index:
    input:
        'filtered/out{sample}.dedupe.bam'
    output:
        'filtered/out{sample}.dedupe.bam.bai'
    log:
        'logs/samtools/{sample}.log'
    benchmark:
        'benchmarks/{sample}.dedupe.bam.bai.benchmark.txt'
    threads: 4
    message: 'executing samtools index on {input} with {threads} threads'
    shell:
        '(samtools index {input}) 2> {log}'