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
#---------------------Still testing
#This should in theory get rid of anything that is normalized. Anything with low expression is eliminated
new_matrix = expression_matrix[,colMeans(expression_matrix)>50]

