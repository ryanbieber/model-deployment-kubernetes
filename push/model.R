## the modelling application
source("parameters.R")


test <- read.csv("data/model_data.csv")

print("Data read from volume mount")

##pushing it to the db if it fails it will tell you and output an error
postgres_push_table(df=test, table_name =  Sys.getenv("TABLE"),dbname =  dbname,port = port,host =  host,user =  user,password =  password,options =  options, new = FALSE, type = FALSE, overwrite = TRUE )


print("Congrats! You have succesfully deployed a model to the Cloud!"))
