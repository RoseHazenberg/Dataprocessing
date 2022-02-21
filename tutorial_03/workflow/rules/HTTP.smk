# Get data with HTTP
from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()

rule download_from_http:
    input:
        HTTP.remote('https://bioinf.nl/~fennaf/snakemake/test.txt')
    output:
        'results/test.txt'
    shell:
        'wget {input} -O {output}'