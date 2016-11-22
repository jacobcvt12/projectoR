

#cor2T<-correlateR(genes="T", dat=p, threshtype="R", threshold=.7, absR=TRUE) 


correlateR<-function(genes=NA, #gene or character vector of genes for reference expression pattern
	dat=NA,
	threshtype="R", #Default "R" indicates thresholding by R value or equivalent. Alternatively, "N" indicates a numerical cut off. 
	threshold=.7, # numeric indicating value at which to make threshold
	absR=FALSE, # logical indicating where to include both positive and negatively correlated genes  
	... # addtion imputs to cor, such as method 
	){
	cor2gene<-apply(dat, 1, function(G) cor(t(p[genes,]), G, ...))
	if(absR){
		if(threshtype=="R"){
			corGS<-list("PositiveCOR"=sort(cor2gene,decreasing=TRUE)[which(sort(cor2gene,decreasing=TRUE)>=threshold)],
					"NegativeCOR"=sort(cor2gene,decreasing=TRUE)[which(sort(cor2gene,decreasing=TRUE)<= -threshold)])
		} else if(threshtype=="N"){
			corGS<-list("PositiveCOR"=sort(cor2gene,decreasing=TRUE)[1:threshold],
					"NegativeCOR"=sort(cor2gene,decreasing=TRUE)[dim(dat)[2]-threshold:dim(dat)[2]])
		}
	} else {
		if(threshtype=="R"){
			corGS<-sort(cor2gene,decreasing=TRUE)[which(sort(cor2gene,decreasing=TRUE)>=threshold)]
		} else if(threshtype=="N"){
			corGS<-sort(cor2gene,decreasing=TRUE)[1:threshold]
		}
	}
	return(corGS)
}


