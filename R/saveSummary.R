
save_audit <- function(result, folder = "audits", month){
  if(!dir.exists(folder))
    dir.create(folder, recursive = TRUE)

  filename <- file.path(folder, paste0("audit_", month, ".rda"))

  save(result, file = filename)

  message("Audit saved to", filename)
}




generate_audit_summary <- function(folder = "audits",

          categories  = c("Tax Computed","Remitance", "Shortfall", "Penalty", "Interest",
                          "Total Shortfall")){
  audit_files <- list.files(folder, pattern = "\\.rda", full.names = TRUE)

  if(length(audit_files) == 0)

    stop("No audit files found in folder: ", folder)


  months <- sub("audit_(.*)\\.rda", "|\1", basename(audit_files))

  monthly_values <- list()

  for (i in seq_along(audit_files)){
    e <- new.env()

    load(audit_files[i], envir = e)

    df <- e$result



    vals <- sapply(categories,
                   function(cat){
                     row <- df[df[,1] == cat, ]

                     if(nrow(row) == 1){
                       return(as.numeric(row[,
                                             ncol(row)]))
                     }else{
                       return(NA_real_)
                     }
                   }
                     )
    monthly_values[[months[i]]] <- vals
  }

  summary_df <- do.call(cbind, monthly_values)

  rownames(summary_df) <- categories

  summary_df <- as.data.frame(summary_df,
                              stringsAsFactor = FALSE)

  return(summary_df)
}

