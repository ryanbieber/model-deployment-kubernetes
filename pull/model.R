## the modelling application
source("parameters.R")


##making some test data from base R if you are using data from the data folder you will need to import it in this step
test <- cbind.data.frame(ldeaths, mdeaths)
##
## cleaning steps not present in this test example
##

print("Data cleaned and ready for modelling")

write.csv(test, file = "data/pull_data.csv", row.names = FALSE)

print("Data has been copied to the data/pull_data.csv")