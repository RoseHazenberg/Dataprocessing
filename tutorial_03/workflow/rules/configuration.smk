# Merge variants workflow merging the data with the use of a configuration filer()
configfile: 'config/config.yaml'
url = config['url']

rule download:
    output:
        'data/{sample}.bam'
    shell:
        'wget {url} -O {output}'