## put the parameters you want hard coded into the program in this one
source("functions.R")

dbname <- Sys.getenv("DBNAME")
host <- Sys.getenv("HOSTNAME")
port <- Sys.getenv("PORT")
user <- Sys.getenv("USERNAME")
password <- Sys.getenv("PASSWORD")
options <- Sys.getenv("SCHEMA")

