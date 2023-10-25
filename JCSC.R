###---PACKAGES---------------------------------------------#########
install.packages("dplyr")
install.packages("data.table")
install.packages("tidyverse")
library(dplyr)
library(data.table)
library(tidyverse)
####################################################################

#define work directory

setwd(
  "DIRECTORY")

#define filename of .csv file in work directory

Filename= "FILENAME.csv"

####################################################################

x<-read.csv(
  Filename
  , sep=";", header=TRUE, stringsAsFactors=TRUE)
x$strand <-
  ifelse(x$REF == "A"| x$REF =="G", "1","0")
x$DATASET <-
  gsub('_','-',x$DATASET)
colnames(x)[1] <- "POS"

y<- x %>%
  select (1,2)

z<- x %>%
  select (1,3,16)
z<-z[!duplicated(z),]

#Aggregate lines of data to sum up DNA/RNA reads

Read_aggr_DNA <- as.data.table(x)[, sum(DNA), by = .(POS)]
colnames(Read_aggr_DNA)[2] <- "DNA"
Read_aggr_A_DNA <- as.data.table(x)[, sum(A_DNA), by = .(POS)]
colnames(Read_aggr_A_DNA)[2] <- "A_DNA"
Read_aggr_C_DNA <- as.data.table(x)[, sum(C_DNA), by = .(POS)]
colnames(Read_aggr_C_DNA)[2] <- "C_DNA"
Read_aggr_G_DNA <- as.data.table(x)[, sum(G_DNA), by = .(POS)]
colnames(Read_aggr_G_DNA)[2] <- "G_DNA"
Read_aggr_T_DNA <- as.data.table(x)[, sum(T_DNA), by = .(POS)]
colnames(Read_aggr_T_DNA)[2] <- "T_DNA"
Read_aggr_RNA <- as.data.table(x)[, sum(RNA), by = .(POS)]
colnames(Read_aggr_RNA)[2] <- "RNA"
Read_aggr_A_RNA <- as.data.table(x)[, sum(A_RNA), by = .(POS)]
colnames(Read_aggr_A_RNA)[2] <- "A_RNA"
Read_aggr_C_RNA <- as.data.table(x)[, sum(C_RNA), by = .(POS)]
colnames(Read_aggr_C_RNA)[2] <- "C_RNA"
Read_aggr_G_RNA <- as.data.table(x)[, sum(G_RNA), by = .(POS)]
colnames(Read_aggr_G_RNA)[2] <- "G_RNA"
Read_aggr_T_RNA <- as.data.table(x)[, sum(T_RNA), by = .(POS)]
colnames(Read_aggr_T_RNA)[2] <- "T_RNA"

Read_merge<- merge(
  merge(
    merge(
      merge(
        merge(
          merge(
            merge(
              merge(
                merge(
    Read_aggr_DNA,Read_aggr_A_DNA, by = "POS"),
  Read_aggr_C_DNA, by = "POS"),
  Read_aggr_G_DNA, by = "POS"),
  Read_aggr_T_DNA, by = "POS"),
  Read_aggr_RNA, by = "POS"),
  Read_aggr_A_RNA, by = "POS"),
  Read_aggr_C_RNA, by = "POS"),
  Read_aggr_G_RNA, by = "POS"),
  Read_aggr_T_RNA, by = "POS")


#select frame, pos, strand, ref
#collapse dataset_pos_ref_strand
#index input table with dataset_pos_stramd_ref tag


y <- y[,c(2,1)]


colnames(y)[1] <- "frame"
colnames(y)[2] <- "POS"

split_list_y<-split.data.frame(
  y,y$frame)

split_list_y[1]
split_list_y[2]

y_names <- names(split_list_y)
y_names2 <- as.data.frame(
  names(split_list_y))


for(
  i in seq_along(y_names)
){
  assign(
    y_names[i], split_list_y[[i]])
}

#add samplenames (in "DATASET" column)

common_df_all <- merge(
  merge(
  `SAMPLENAME1`,
  `SAMPLENAME2`,by = "POS", all=TRUE),
  `...`,by = "POS", all=TRUE)

#add samplenames (in "DATASET" column)

colnames(common_df_all)[2] <- "SAMPLENAME1"
colnames(common_df_all)[3] <- "SAMPLENAME2"
colnames(common_df_all)[4] <- "..."

common_df_all<-
  merge.data.frame(common_df_all,z, by = "POS", all.x = TRUE, all.y = TRUE)
common_df_all2<-
  merge.data.frame(common_df_all,Read_merge, by = "POS", all.x = TRUE, all.y = TRUE)

#add filename of output file

write.csv(
  common_df_all2,file=paste(
    Filename, "FILENAME_JCSC.csv"), quote = FALSE)

##############################################################DONE##
