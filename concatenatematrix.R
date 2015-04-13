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

expression_list = lapply(GEO_list, exprs)

for(x in seq_along(expression_list)){
  if( is.na(median(rowMeans(expression_list[[x]]))) == TRUE ){
   expression_list[[x]] = NULL
   
  }
}

#Some datasets give a median of NA. Need to get rid of those and anything less than 100. [[4]] and [[24]] are NA.
for(x in seq_along(expression_list)){
  print(median(rowMeans(expression_list[[x]])))
}
}