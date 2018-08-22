awk 'FNR==NR{if($4>=10){exists[$2]++; meth[$2]=$NF/100};next} {
n3=split($NF, sites, ","); 
d=0;counter=0; for (i=1;i<=length(sites);i++){
    if(exists[sites[i]]>0){
        d+=meth[sites[i]]; counter++ }else {print sites[i] > "/dev/stderr"}} ;
print $4, $14, d/counter}' MODERN_METHYLATION.data deammeth_res/20.F > to_plot.txt

Rscript -e 'df=read.table("to_plot.txt");df=subset(df,V1>312500);pdf("result.pdf");plot(df[,1], df[,2]); lines(df[,1],df[,3],type="l", col="red");dev.off()' 
