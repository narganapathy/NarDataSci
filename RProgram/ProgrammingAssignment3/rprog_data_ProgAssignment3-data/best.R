best <- function(state, outcome) {
## Read outcome data
## Check that state and outcome are valid
## Return hospital name in that state with lowest 30-day death
## rate
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
   
   minmortalityrate <- min(as.numeric(filteredHospitalData[,2]), na.rm = TRUE)
   ##print(minmortalityrate )
   minfilter <-  (as.numeric(filteredHospitalData[,2]) == minmortalityrate)
   ##print(minfilter)
   topHospitals <- sort(filteredHospitalData[minfilter,1])
   print(topHospitals)
   ##filteredHospitalData 
}