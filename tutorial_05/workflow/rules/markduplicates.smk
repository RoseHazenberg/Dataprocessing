"""
All the rules that use MarkDuplicates as command are in this file.
#detect_and_remove_duplicates, detects and removes the duplicates
"""

rule detect_and_remove_duplicates:
    input:
        'sorted/out{sample}.sorted.bam'
    output:
        'filtered/out{sample}.dedupe.bam'
    log:
        'logs/markduplicates/{sample}.log'
    benchmark:
        'benchmarks/{sample}.dedupe.bam.benchmark.txt'
    threads: 4
    message: 'executing detection and removal of duplicates on {input} to generate {output} with {threads} threads'
    shell:
        '(java -jar ../../picard/build/libs/picard.jar MarkDuplicates \
                            -MAX_FILE_HANDLES_FOR_READ_ENDS_MAP 1000 \
                            -METRICS_FILE results/out.metrics \
                            -REMOVE_DUPLICATES true \
                            -ASSUME_SORTED true  \
                            -VALIDATION_STRINGENCY LENIENT \
                            -INPUT {input} \
                            -OUTPUT {output}) 2> {log}'