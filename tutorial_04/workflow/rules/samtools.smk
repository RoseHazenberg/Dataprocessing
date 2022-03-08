"""
All the rules that use samtools as command are in this file.
#samtools_sort, convert the .sam file into a .bam file and sort it
"""

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