all_miRNA<-as.data.frame(read.csv("/Users/taniapeniche/Desktop/Trabalho_GEM/miRWalk_miRNA_Targets.csv"))

View(all_miRNA)

names_miRNA<-unique(all_miRNA$mirnaid)


miRNA_validated<- all_miRNA[all_miRNA$validated !="" , ]
names_miRNA_validated<- intersect(miRNA_validated$mirnaid, names_miRNA)

length(miRNA_validated$validated)


#geneVs.Transcription Factor.

TAF1_miRNA<-as.data.frame(read.csv("/Users/taniapeniche/Desktop/TAF1.csv"))
comun_TAF1<-unique(intersect(TAF1_miRNA$mirnaid, all_miRNA$mirnaid))

TAF1_miRNA_validated<-STAT1_miRNA[TAF1_miRNA$validated !="",  ]

comun_TAF1_all_miRNA<-intersect(TAF1_miRNA_validated$mirnaid, miRNA_validated$mirnaid)


REST_miRNA<-as.data.frame(read.csv("/Users/taniapeniche/Desktop/REST.csv"))
comun_REST<-unique(intersect(REST_miRNA$mirnaid, all_miRNA$mirnaid))

REST_miRNA_validated<-REST_miRNA[REST_miRNA$validated !="",  ]

comun_REST_all_miRNA<-intersect(REST_miRNA_validated$mirnaid, miRNA_validated$mirnaid)


SIN3A_miRNA<-as.data.frame(read.csv("/Users/taniapeniche/Desktop/SIN3A.csv"))
comun_SIN3A<-unique(intersect(SIN3A_miRNA$mirnaid, all_miRNA$mirnaid))

SIN3A_miRNA_validated<-SIN3A_miRNA[SIN3A_miRNA$validated !="",  ]

comun_SIN3A_all_miRNA<-intersect(SIN3A_miRNA_validated$mirnaid, miRNA_validated$mirnaid)
