awk 'FNR==NR{if($4>=10){exists[$2]++; meth[$2]=$NF/100};next} FNR==1{next};{
n3=split($NF, sites, ","); 
d=0;counter=0; for (i=1;i<=length(sites);i++){
    if(exists[sites[i]]>0){
        d+=meth[sites[i]]; counter++ }else {print $4, sites[i] > "/dev/stderr"}} ; n4=split($1, abc, ":");
print abc[2], $6, d/counter}' MODERN_METHYLATION.data dammet_res.20.F > to_plot.txt

Rscript -e 'df=read.table("to_plot.txt");df=subset(df,V1>312500);pdf("result.pdf");plot(df[,1], df[,2],xlab="Genomic region (chr20;GRCh38)",ylab="Methylation levels",ylim=c(0,1)); lines(df[,1],df[,3],type="l", col="red");dev.off()' 
