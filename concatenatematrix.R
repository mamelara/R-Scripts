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





#---------------------Still testing
#Graham says that he takes the row means of the dataset and then takes the median of the average expression. 
#If the median of the averages is less than 100 he throws the entire thing out.
expression_matrix = cbind(expression_matrix,rowMeans(expression_matrix))

if(median(expression_matrix[,ncol(expression_matrix)]) < 100) {
   rm(expression_matrix) }
else{
    return(expression_matrix[,-ncol(expression_matrix)]) }
}
