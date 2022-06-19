setwd("")
install.packages("data.table")
library(data.table)
result<-fread("result.txt")
header<-fread("header.txt")
names(result)=colnames(header)
data<-rbind(header,result)
View(data)
metadata<-t(data)[-1:-2,]
View(metadata)

#CREATE THE TABLE: sample|GTEX|all the features(GENEEXP,TISSUE,SEX,AGE)
sample_attributes<-fread("SampleAttributes.txt")
subject_phenotypes<-fread("SubjectPhenotypes.txt")

View(sample_attributes)
View(subject_phenotypes)

#tissues<-sample_attributes[match(metadata[,1],unlist(sample_attributes[,1])),"SMTSD"]
#View(tissues)

tissues<-sample_attributes[match(metadata[,1],unlist(sample_attributes[,1])),"SMTS"]

metadata_<-cbind(metadata,tissues)
View(metadata_)
metadata_[,1]

ids<-sapply(unlist(metadata_[,1]),function(x)paste(unlist(strsplit(x,"-"))[1:2],collapse = "-"))
features<-subject_phenotypes[match(ids,unlist(subject_phenotypes[,1])),c("SEX","AGE")]

final_metadata<-cbind(metadata_,features)
View(final_metadata)

library(dplyr)
meta_data
meta_data<-rename(final_metadata,c("Samples"="V1","GeneExp"="V2","Tissues"="SMTS"))
View(meta_data)
meta_data$GeneExp<-as.numeric(meta_data$GeneExp)

save(meta_data,file = "meta_data.RData")
#save(final_metadata,file = "metadata.RData,"file.data")
#rgalleray

##########
#GRÁFICOS#
##########
setwd("")
load("meta_data.RData")

par(mfrow=c(1,2))
#PIE CHART- AGE
pie(table(meta_data$AGE),radius = 1, main = "Age")
#PIE CHART- SEXO
pie(table(meta_data$SEX),radius=1,labels = c("Male","Female"),main = "Sex")

View(meta_data)
geneExp<-as.numeric(meta_data$GeneExp)

# Boxplot of gene expression levels splitting samples according to tissues
pdf("Gene_expression_levels_splitting_samples_to_tissues.pdf")
par(oma=c(15,0,0,0))
boxplot(geneExp~meta_data$Tissues,ylab="Gene Expression Levels ",xlab="",col = rainbow(30),las=2,outline=FALSE,cex=0.0075)
title(main="Gene expression levels splitting samples according to tissues")
dev.off()