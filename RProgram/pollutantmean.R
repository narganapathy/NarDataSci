pollutantmean <- function(directory, pollutant, id = 1:332) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files
	  ## setwd(directory)
	  files = list.files(directory, full.names = TRUE)
	  filestolook = files[id]

	  intersum <- 0
	  interlength <- 0
	  for (i in filestolook)
	  {
		singlefiledata = read.csv(i)
		pollutantvals = singlefiledata[pollutant]
		filterarray = !is.na(pollutantvals)
		finalvals = pollutantvals[filterarray ]

		intersum <- intersum +  sum(finalvals)
		interlength <- interlength + length(finalvals)

	  }
	  mean = intersum / interlength
}