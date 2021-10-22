setwd("C:/Users/andre/Desktop/CMSC197")                                           # Set the working directory to "CMSC 197"

# Problem 1

pollutantMean <- function(directory, pollutant, id = 1:332){                      # Create a function for variable 'pollutantMean' with three arguments: 
                                                                                  # directory as a character vector that indicates the location of a certain folder that contains the csv files you want to use; 
                                                                                  # pollutant as a character vector that indicates the name of the pollutant in the csv files;
                                                                                  # id as an integer vector that indicates the id numbers in the csv files.
  files <- list.files(path = directory, pattern = ".csv", full.names = TRUE)      # Create a list of files in a directory particularly the csv files         
  data <- data.frame()                                                            # Create an empty data frame to store data from the loop and to be assigned in the variable 'data'
  for(x in id){                                                                   # Create a for loop to read the files
    temp <- read.csv(files[x])                                                    # The function read.csv reads the data from the list of multiple files in the directory and is stored to the variable 'temp'
    data <- rbind(data, temp)                                                     # The rbind function concatenates the data from the variable 'tmp' to the variable 'data'
  }
  mean(data[[pollutant]], na.rm = TRUE)                                           # Calculate the mean of the pollutant while ignoring the NA values
}

# Sample code

pollutantMean("specdata", "sulfate", 1:10)

# Problem 2

complete <- function(directory, id = 1:332){                                      # Create a function for variable 'complete' with two arguments:
                                                                                  # directory as a character vector that indicates the location of a certain folder that contains the csv files you want to use; 
                                                                                  # and id as an integer vector that indicates the id numbers in the csv files.
  files <- list.files(path = directory, pattern = ".csv", full.names = TRUE)      # Create a list of files in a directory particularly the csv files    
  nobs <- numeric()                                                               # Create an empty numeric vector to store the number of completely observed cases from the loop and to be assigned in the variable 'nobs'
  
  for(x in id){                                                                   # Create a for loop to read the files
    tmp <- sum(complete.cases(read.csv(files[x])))                                # The function sum appends the number of complete cases inside the csv files and all the data is stored in the variable 'tmp'
    nobs <- c(nobs, tmp)                                                          # The c() function combines the data from the variable 'tmp' to the variable 'nobs' 
  }
  data.frame(id, nobs)                                                            # The data.frame function returns the data from 'id' and 'nobs'
}

# Sample code

complete("specdata", c(2, 4, 8, 10, 12))


# Problem 3

corr <- function(directory, threshold = 0){                                        # Create a function for variable 'corr' with two arguments:
                                                                                   # directory as a character vector that indicates the location of a certain folder that contains the csv files you want to use; 
                                                                                   # and 'threshold' assigned with 0 
  files <- list.files(path = directory, pattern = ".csv", full.names = TRUE)       # Create a list of files in a directory particularly the csv files
  com <- complete(directory)                                                       # The directory is passed on the complete function and is assigned in the variable 'com'
  data_corr <- numeric()                                                           # Create an empty numeric vector to store the correlation between sulfate and nitrate from the loop and the data will be assigned in the variable 'data_corr'
  
  for(x in com$id){                                                                # Create a for loop to read the files and to access the indices of the csv files
    temp <- read.csv(files[x])                                                     # The function read.csv reads the data from the list of files from the directory is stored to the variable 'temp'
    temp_corr <- temp[complete.cases(temp),]                                       # Access the rows of the variable 'temp' and perform the complete.cases function that removes NA values and all the data is assigned in variable 'temp_corr'
    
    if(com$nobs[x] > threshold){                                                   # Create an if statement that returns the vector of correlation of the two pollutants with values greater than the threshold input
      data_corr <- c(data_corr, cor(temp_corr$sulfate, temp_corr$nitrate))         # The values of cor() function are appended to the empty vector which is assigned to variable 'data_corr'
    }
  }
  return(data_corr)                                                                # Return the values of variable 'data_corr'
}

# Sample code 

cr <- corr("specdata")
head(cr); summary(cr); length(cr)

# Problem 4

setwd("C:/Users/andre/Desktop/CMSC197/hospdata")                                  # Set the working directory to "hospdata"

outcome <- read.csv('outcome-of-care-measures.csv', colClasses = "character")     # Create a vector of column classes specified as a character from the csv file and are stored in the variable 'outcome'
ncol(outcome)                                                                     # Number of columns in variable 'outcome'
names(outcome)                                                                    # Names of each column 
outcome <- as.numeric(outcome[, 11])                                              # Column 11 of outcome is coerced as a numeric value and the data are stored in the same variable
hist(outcome,                                                                     # Create a histogram for outcome
     main = "Hospital 30-Day Death (Mortality) Rate from Heart Attack",           # main sets the title of the histogram
     cex.main = 0.95,                                                             # cex.main adjusts the font size of the main
     cex.lab = 0.8,                                                               # cex.lab adjusts the font size of both x-axis and y-axis descriptions
     cex.axis = 0.8,                                                              # cex.axis adjusts the size of both x-axis and y-axis numbers
     xlab = "Deaths",                                                             # xlab sets the description for x-axis
     col = "light blue")                                                          # col sets the color for the bars