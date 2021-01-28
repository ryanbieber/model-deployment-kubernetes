## the modelling application
source("parameters.R")



test <- read.csv("data/pull_data.csv")

print("Data read from volume mount")

##modelling on that test data and capturing the output
test_model <- TimeSeriesCatchAll::all_in_one_time_series(test)

print("modelling done")
transposed_model <- t(test_model)

write.csv(transposed_model, file = "data/model_data.csv", row.names = FALSE)

print("Data has been copied to the data/model_data.csv")



