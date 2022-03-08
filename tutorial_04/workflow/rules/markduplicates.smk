rule detect_and_remove_duplicates:
    input:
        'sorted/out{sample}.sorted.bam'
    output:
        'filtered/out{sample}.dedupe.bam'
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