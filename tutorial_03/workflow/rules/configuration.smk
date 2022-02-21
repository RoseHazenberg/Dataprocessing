# Merge variants workflow merging the data with the use of a configuration file
from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()
configfile: 'config/config.yaml'

rule fetch_data:
    input:
        HTTP.remote('https://bioinf.nl/~fennaf/snakemake/WC03/data')
    shell:
        'wget {input}'

rule merge_variants:
    input:
        fa = config['genome'] + config['ext'],
        fai = config['genome'] + config['ext'] + '.fai',
        dict = config['genome'] + '.dict',
        vcf = expand('calls/{sample}.g.vcf', sample=config['samples'])
    output:
        temp('calls/merged_results.vcf')
    message: 'Executing GATK CombineGVCFs with {threads} threads on the following {input}.'
    shell:
        "wget config['data']"
        'java -jar ./GATK/GenomeAnalysisTK.jar -T CombinedGVCFs -R {input.fa} {vcf2} -o {output}'

