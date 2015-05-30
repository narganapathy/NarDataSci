rankhospital <- function(state, outcome, num= "best") {
## Read outcome data
## Check that state and outcome are valid
## Return hospital name in that state with 30-day death
## rate for that rank
   rank = num
   hospitaldata <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
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
   statefilter <- (hospitaldata[,7] == state)
   filteredHospitalData <- hospitaldata[statefilter, c(2,index)]
   ##print(filteredHospitalData )
   if (nrow(filteredHospitalData) == 0)
   {
	 stop("Invalid state");
   }
   
   sortOrder <- suppressWarnings(order(as.numeric(filteredHospitalData[,2]), filteredHospitalData[,1], na.last = NA))
   sortedMortalityRate <- filteredHospitalData[sortOrder,1]
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

   ##print(minmortalityrate )
   if ((rank > 0) && (length(sortedMortalityRate)  < rank ))
   {
	   NA
   }
   else
   {
	   sortedMortalityRate[rank]
	   ##print(sortedMortalityRate)
       ##rankMortalityRate =  sortedMortalityRate[rank];
	   ##print(rankMortalityRate)
	   #minfilter <-  (as.numeric(filteredHospitalData[,2]) == rankMortalityRate)
	   ##print(minfilter)
	   #topHospitals <- sort(filteredHospitalData[minfilter,1])
	   #print(topHospitals)
   }
}
