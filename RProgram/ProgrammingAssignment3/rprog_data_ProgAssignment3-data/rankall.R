
rankall <- function(outcome, num = "best") {

	## Read outcome data
	## Check that state and outcome are valid
	## Return hospital name in that state with 30-day death
	## rate for that rank
	rankhospital <- function(state, rank= "best") {
	   statefilter <- (hospitaldata[,7] == state)
	   filteredHospitalData <- hospitaldata[statefilter, c(2,7,index)]
	   if (nrow(filteredHospitalData) == 0)
	   {
		 stop("Invalid state");
	   }
	   
	   ##print(filteredHospitalData)
	   sortOrder <- suppressWarnings(order(as.numeric(filteredHospitalData[,3]), filteredHospitalData[,1], na.last = NA))
	   sortedMortalityRate <- filteredHospitalData[sortOrder,1]
	   ##print(sortedMortalityRate)
	   if (!is.numeric(rank))
	   {
		   if (rank == "best") 
		   {
				   rank = as.numeric(1);
		   }
		   else if (rank == "worst") 
		   {
				   rank = length(sortedMortalityRate);
		   }
		   else { stop("Invalid rank") }
	   }

	   if ((rank > 0) && (length(sortedMortalityRate)  < rank ))
	   {
		   NA
	   }
	   else
	   {
		   sortedMortalityRate[rank]
	   }
	}
## Read outcome data
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name
   if (outcome == "heart attack")
   {
      index = 11
   
   }
   else if (outcome == "heart failure")
   {
	index = 17
   }		
   else if (outcome == "pneumonia")
   {
      index = 23
   }
   else
   {	
	 stop("Invalid outcome");
   }
   hospitaldata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
   state <- sort(unique(hospitaldata[,7]))
   hospital <- sapply(state, rankhospital, rank=num)
   data.frame(hospital, state)
}
