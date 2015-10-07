generateMatrix <- function(dim=1000, depth=50){
	file_name <- "terrain.dat"
	if (file.exists(file_name)){
		file.remove(file_name)
	}
	file.create(file_name)
	d <- dim
	write.table(d,file_name, sep = " ",row.names = F,col.names = F,fileEncoding = "UTF-8")
	m <- matrix(nrow = dim,ncol = dim)

	for (i in 1:dim)  {
		m[i,]<-sample(0:depth,size=dim,replace = T)
	}
	write.table(m,file_name,append = T, sep = " ", row.names = F,col.names = F, fileEncoding = "UTF-8")
}
