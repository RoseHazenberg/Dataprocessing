# Merge variants workflow merging the data with the use of a configuration filer()
configfile: 'config/config.yaml'
url = config['url']

rule all:
    input:
        expand('data/{sample}.bam', sample=[x for x in config['samples']])

rule download:
    output:
        'data/{sample}.bam'
    shell:
        'wget {url} -O {output}'

# rule merge_variants:
#     input:
#         fa = config['genome'] + config['ext'],
#         fai = config['genome'] + config['ext'] + '.fai',
#         dict = config['genome'] + '.dict',
#         vcf = expand('calls/{sample}.g.vcf', sample=config['samples'])
#     output:
#         temp('calls/merged_results.vcf')
#     message: 'Executing GATK CombineGVCFs with {threads} threads on the following files {input}'
#     shell:
#         'java -jar ./GATK/GenomeAnalysisTK.jar -T CombineGVCFs -R {input.fa} {vcf2} -o {output}'