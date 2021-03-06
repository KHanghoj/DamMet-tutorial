#!/usr/bin/env bash
BAM=test.bam
# N positions to estimate deamination rates from each end
MAX_POS=30
# path to reference genome
FASTA=hg38.20.fa.gz
# chromosome to analyze
CHROM=20
# minimum mapping quality
minMapQ=1
# minimum base quality
minBaseQ=1
# global prior on the fraction of methylated CpG's
M=0.75
# CpGs to exclude due to low coverage
EXCLUDE=EXCLUDE.CpGs.txt
# N cpgs to include per window for estimating $f$
NCPG=50
#OUT PREFIX
OUT=dammet_res
# Using precalculated Deamination rates as the provided bam only covers a window of 30kb bp.
PRECALCDEAM=test.deamrates
# No need to run estDEAM as we have estimated the deaminations rates in this tutorial already. Below is the command to estimate them from the data if needed.

# ../DamMet/DamMet estDEAM -b ${BAM} -r ${FASTA} -c ${CHROM} -q ${minMapQ} -Q ${minBaseQ} -P ${MAX_POS} -M ${M} -O ${OUT} -E ${EXCLUDE} -skip -verbose

../DamMet/DamMet estF -b ${BAM} -r ${FASTA} -c ${CHROM} -q ${minMapQ} -Q ${minBaseQ} -P ${MAX_POS} -M ${M} -O ${OUT} -N ${NCPG} -E ${EXCLUDE} -D ${PRECALCDEAM} -verbose -skip_empty_cpg

# plot results against methylation levels from a modern sample.
bash mergeFwithModern.sh
