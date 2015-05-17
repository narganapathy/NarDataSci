complete <- function(directory, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
	  ## setwd(directory)
	  files = list.files(directory, full.names = TRUE)
	  filestolook = files[id]
	  ## print (filestolook)
	  lengthlist <- c()
	  for (i in filestolook)
	  {
		singlefiledata = read.csv(i)
		## get na array for sulfate
		sulfatevals <- singlefiledata["sulfate"]
		sulfatenaarray <- !is.na(sulfatevals)
		nitratevals <- singlefiledata["nitrate"]
		nitratenaarray <- !is.na(nitratevals )

		completearray <- sulfatenaarray & nitratenaarray
		finalarray <- completearray[completearray]
		completeLength <- length(finalarray)
		lengthlist <- c(lengthlist, completeLength)
	  }
	  finaldataframe <- data.frame("id"=id, "nobs"=lengthlist)
}

