# Get data from NCBI
from snakemake.remote.NCBI import RemoteProvider as NCBIRemoteProvider
NCBI = NCBIRemoteProvider(email='c.r.hazenberg@st.hanze.nl')

rule download_from_ncbi:
    input:
        NCBI.remote('KY785484.1.fasta', db='nuccore')
    output:
        'results/test.fasta'
    run:
        shell('mv {input} {output}')