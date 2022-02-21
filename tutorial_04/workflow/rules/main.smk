datadir= '/commons/Themas/Thema11/Dataprocessing/WC04/data/'

rule all:
    """ final rule """
    input: 'results/heatmap.jpg'


rule make_heatmap:
    """ rule that creates heatmap"""
    input:
        datadir + 'gene_ex.csv'
    output:
         'results/heatmap.jpg'
    shell:
        'Rscript workflow/scripts/scriptheatmap.R {input} {output}'