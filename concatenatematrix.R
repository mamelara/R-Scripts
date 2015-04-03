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

#Create an expression matrix with the first entry of the list
expression_matrix = exprs(GEO_list[[1]])


#Then loop through the remaining entries of the list
for(i in 2:length(GEO_list)) {
  expression_matrix = combine(expression_matrix,exprs(GEO_list[[i]]))
}
#Get rid of NA's
expression_matrix = expression_matrix[complete.cases(expression_matrix),]



}
#-----------------------------------------------------Testing function for eliminating log transformed data
for(i in 1:ncol(standard_matrix)){
  q = qqnorm(standard_matrix[,i])
  q.lm = lm(q$y~q$x)
  if(q.lm$coefficients == 1.0) {
    norm = standard_matrix[,i]
  }
  
}
