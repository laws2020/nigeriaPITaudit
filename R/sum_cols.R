

#' Summarize Selected Numeric Columns in a Data Frame
#'
#' This function computes the column-wise sum of user-specified numeric columns in a given data frame.
#' It retains all original columns, appending a "Total" row at the bottom for selected columns.
#' Non-numeric columns remain unchanged, with `NA` added to the "Total" row.
#'
#' @param df A data frame containing numeric and non-numeric columns.
#' @param cols_to_sum A character vector specifying the names of numeric columns to be summed.
#'
#' @return A modified data frame where the specified numeric columns have an additional "Total" row,
#' while all other columns remain intact.
#'
#' @details
#' - This function supports numeric, factor, and character columns.
#' - Character columns in `cols_to_sum` are automatically converted to numeric if possible.
#' - Non-numeric columns are preserved and filled with `NA` in the "Total" row.
#' - If `cols_to_sum` contains invalid column names, the function returns an error.
#'
#' @examples
#' df <- data.frame(
#'   ID = c(1, 2, 3, 4, 5),
#'   Name = c("Alice", "Bob", "Charlie", "David", "Eve"),
#'   Age = c(25, 30, 22, 28, 35),
#'   Income = c("50000", "60000", "45000", "70000", "80000"),
#'   Status = as.factor(c("Single", "Married", "Single", "Married", "Single")),
#'   Score = c(85.5, 90.2, 78.0, 88.8, 92.3)
#' )
#' sum_cols(df, c("Age", "Income", "Score"))
#'
#' @export
sum_cols <- function(df, cols_to_sum) {
  if (!is.data.frame(df)) {
    stop("Error: Input must be a dataframe.")
  }
  
  if (!all(cols_to_sum %in% colnames(df))) {
    stop("Error: Some specified columns do not exist in the dataframe.")
  }
  
  # Separate specified numeric columns
  df_numeric <- df[, cols_to_sum, drop = FALSE]
  
  # Convert character columns to numeric where applicable
  df_numeric <- data.frame(lapply(df_numeric, function(col) {
    if (is.character(col)) {
      suppressWarnings(as.numeric(col))  # Convert character to numeric
    } else {
      col  # Keep numeric columns unchanged
    }
  }))
  
  # Compute column sums
  sums <- colSums(df_numeric, na.rm = TRUE)
  
  # Append sums as a new row
  df_numeric <- rbind(df_numeric, sums)
  rownames(df_numeric)[nrow(df_numeric)] <- "Total"
  
  # Preserve all non-specified columns
  df_non_numeric <- df[, !colnames(df) %in% cols_to_sum, drop = FALSE]
  
  # Add an empty row for non-numeric columns
  df_non_numeric[nrow(df_numeric), ] <- NA
  
  # Combine numeric and non-numeric columns while keeping the original order
  df_final <- cbind(df_numeric, df_non_numeric)[, colnames(df), drop = FALSE]
  
  return(df_final)
}
