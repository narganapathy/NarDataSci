corr <- function(directory, threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        id = 1:332
	  files = list.files(directory, full.names = TRUE)
	  filestolook = files[id]
	  ## print (filestolook)
	  lengthlist <- c()
	  corrvallist <- c()
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
		
		if (length(finalarray)> threshold)
		{
			corrval <- cor(sulfatevals[completearray ], nitratevals[completearray])
			corrvallist <- c(corrvallist, corrval)
		}
		
	  }
	  corrvallist
}
