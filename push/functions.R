## place the functions you are using for your application
postgres_push_table <- function(df, table_name,  dbname, port, host, user,password, options, new=FALSE, type = TRUE,  overwrite=TRUE){
  ##connection string
  conn <- RPostgres::dbConnect(RPostgres::Postgres(),dbname=dbname , 
                               host=host, 
                               port=port, 
                               user=user ,
                               password=password,
                               options=options)
  print("connected successfully")
  

  
  if (type==TRUE){
    colnames(df) <- tolower(colnames(df))
    type <- RPostgres::dbGetQuery(conn, paste0("SELECT * FROM ",table_name))

    if (NCOL(type)!=NCOL(df)){
      stop("DB and DF do not have equal columns!")
    }

    colnames(df) <- tolower(colnames(df))
    column_coarce <- function(df, type){
      for ( i in colnames(type)){
        if (class(type[,i])=="character"){
          df[,i] <- as.character(df[,i])
        } else {
          df[,i] <- as.numeric(df[,i])
        }
      }
      return(df)
    }
    df <- column_coarce(df, type)
    print("coerced column names")

  } else {
    ##df types are already accurate
  }
  
  
  push_failed <- FALSE
  
  tryCatch( if (new==TRUE&overwrite==FALSE){
    RPostgres::dbWriteTable(conn, table_name, value = df)
    print("Pushed table")
    
  } else if (new==FALSE&overwrite==FALSE) {
    RPostgres::dbWriteTable(conn, table_name, value = df,  append = TRUE)
    print("pushed table")
    
  } else if (new==FALSE&overwrite==TRUE){
    RPostgres::dbWriteTable(conn, table_name, value = df,  overwrite = TRUE)
    print("Pushed table")
    
  } else {
    RPostgres::dbDisconnect(conn)
    stop("Both overwrite and new can't equal TRUE")
  }
  
  
  , error = function(e) { push_failed <<- TRUE})
  
  if(push_failed) { RPostgres::dbDisconnect(conn)
    stop("Push Failed")
  } 
  
  RPostgres::dbDisconnect(conn)
  
}

