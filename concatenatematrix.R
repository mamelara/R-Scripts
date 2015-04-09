#!/usr/bin/env Rscript
yeast = function(){
#This function loops through files in a directory
require(Biobase)
require(GEOquery)
require(impute)

dirpath = setwd("~/Documents/Thomson Lab/GPL90")
myFiles = list.files(dirpath,pattern="*.txt",full.name=T)
GEO_list = lapply(myFiles,function(x){
    getGEO(filename=as.character(x),GSEMatrix=TRUE)})

#Create an empty matrix to start appending to?

#Then loop through the remaining entries of the list, first check the rowMeans of the entry. If it's less than 100 delete it.
#Take row means of every dataset and then check the maximum value. Then you want to get rid of expressions < 200 of each row
for(i in 1:length(GEO_list)) {
  if(max(rowMeans(exprs(GEO_list[[i]]))) < 100){
      GEO_list[[i]] = NULL
  }
  


#Get rid of NA's
expression_matrix = expression_matrix[complete.cases(expression_matrix),]





#---------------------Still testing
#Graham says that he takes the row means of the dataset and then takes the median of the average expression. 
#If the median of the averages is less than 100 he throws the entire thing out.
gene_expression_means = rowMeans(expression_matrix)

#if(median(gene_expression_means) < 100) {
#   rm(expression_matrix) }
#else{
#    return(expression_matrix)
#}
}