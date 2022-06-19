#######################################################################
#Assess which TF are in fact co-expressed with our gene target#
#######################################################################
setwd("")
library(data.table)
#PREDICTION:
RNF20_predict_data<-fread("AnimalTFDB_tfbs_predict_result.txt",col.names = c("TF","Source","Sequence","Start","Stop","Strand","Score","P-value","Q-value","Matched Sequences"," "))
View(RNF20_predict_data)
RNF20_predict<-RNF20_predict_data[RNF20_predict_data$`Q-value`<"0.05"]
View(RNF20_predict)

FT_UCSC<-c("RFX5","STAT1","TAF1","TRIM22","REST","GABPA","MAFK","TBP","FOXA1","SIN3A","SP1","GATA2","MYC1","FOS")
unique_FT<-unique(RNF20_predict$TF)
View(unique_FT)
intersect_FT<-intersect(FT_UCSC,unique_FT)
View(intersect_FT)

#gtex
RFX5 <- fread("RFX5.txt")
RFX5 <- t(RFX5)
RFX5 <- RFX5[-c(1, 2),]
STAT1 <- fread("STAT1.txt")
STAT1 <- t(STAT1)
STAT1 <- STAT1[-c(1, 2),]
TAF1 <- fread("TAF1.txt")
TAF1 <- t(TAF1)
TAF1 <- TAF1[-c(1, 2),]
REST <- fread("REST.txt")
REST <- t(REST)
REST <- REST[-c(1, 2),]
GABPA <- fread("GABPA.txt")
GABPA <- t(GABPA)
GABPA <- GABPA[-c(1, 2),]
MAFK <- fread("MAFK.txt")
MAFK <- t(MAFK)
MAFK <- MAFK[-c(1, 2),]
TBP <- fread("TBP.txt")
TBP <- t(TBP)
TBP <- TBP[-c(1, 2),]
FOXA1 <- fread("FOXA1.txt")
FOXA1 <- t(FOXA1)
FOXA1 <- FOXA1[-c(1, 2),]
SIN3A <- fread("SIN3A.txt")
SIN3A<- t(SIN3A)
SIN3A <- SIN3A[-c(1, 2),]
SP1 <- fread("SP1.txt")
SP1 <- t(SP1)
SP1 <- SP1[-c(1, 2),]
GATA2 <- fread("GATA2.txt")
GATA2<- t(GATA2)
GATA2 <- GATA2[-c(1, 2),]
FOS <- fread("FOS.txt")
FOS <- t(FOS)
FOS <- FOS[-c(1, 2),]

View(FOS)

#COMPARAÇÃO DOS NIVEIS DE EXPRESSÃO DO NOSSO GENE E OS GENES DOS FATORES DE TRANSCRIÇÃO QUE INTERSETAMOS
Expression_Table<- rbind("RNF20" = meta_data$GeneExp, "RFX5" = RFX5, "STAT1" = STAT1, "TAF1" = TAF1, "REST" = REST, "GABPA" = GABPA, "MAFK" = MAFK, "TBP" = TBP, "FOXA1" = FOXA1, "SIN3A"= SIN3A, "SP1"= SP1, "GATA2" =GATA2, "FOS" = FOS)
colnames(Expression_Table) <- meta_data$Tissues
View(Expression_Table)

save(Expression_Table,file = "Expression_Table.RData")

load("Expression_Table.RData")
View(Expression_Table)

#CORRELATION TEST (PEARSON'S CORRELATION TEST):
for (n in 2:nrow(Expression_Table)){
  x <- cor.test(as.numeric(Expression_Table[1,]),as.numeric(Expression_Table[n,]))
  print(rownames(Expression_Table)[n])
  print(x)
}


#PLOT CONSTRUCTED TO SHOW HIGHEST CORRELATION (TRANSCRIPTION FACTOR "TAF1" WITH "RNF20":
plot(as.numeric(Expression_Table[1,]),as.numeric(Expression_Table["TAF1",]),ylab = "Expression levels of TAF1", xlab = "Expression levels of RNF20")
abline(coef = c(0.65,0.65),col="red")