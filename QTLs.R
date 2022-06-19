#eQTLs

eQTLs <- read.csv("~/Desktop/eQTLs.csv")

table_e <-as.matrix(table(eQTLs$Tissue))
NES=table(eQTLs$Tissue,eQTLs$NES>0)
table_eQTL=cbind(table_e,NES[,1],NES[,2])

colnames(table_eQTL)<-c("Nr of eQTLs", "Nr of Positive eQTLs", "Nr of Negative eQTLs")

#sQTls

sQTLs <- read.csv("~/Desktop/sQTLs.csv")

table_s <-as.matrix(table(sQTLs$Tissue))
NES=table(sQTLs$Tissue,sQTLs$NES>0)
table_sQTLs=cbind(table_s,NES[,1])

colnames(table_sQTLs)<-c("Nr of sQTLs", "Nr of Positive sQTLs")

#Save tables
pdf("QTLs.pdf", height=11, width=8.5)

grid.table(table_eQTL)
grid.newpage()
grid.table(table_sQTLs)

dev.off()


#ClinVar - NSem re

clinVar <- read.delim("~/Desktop/Trabalho_GEM/clinvar_result-3.txt", fill = TRUE)

rs_signgificant<-intersect(eQTLs$SNP.Id, clinVar$dbSNP.ID)

rs_signgificant_II<-intersect(sQTLs$SNP.Id, clinVar$dbSNP.ID)


#GWAS

GWAS<-read_tsv("~/Desktop/Trabalho_GEM/gwas-association-downloaded_2022-05-23-ensemblMappedGenes_RNF20.tsv")


rs_signgificant_GWAS<-intersect(eQTLs$SNP.Id, GWAS$SNPS)
rs_signgificant_GWAS_II<-intersect(sQTLs$SNP.Id, GWAS$SNPS)

