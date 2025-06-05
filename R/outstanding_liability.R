

#' Outstanding Employee Tax Liability
#'
#' The \code{outstanding_liability()} function calculates the remaining tax liability
#' of an employee after considering payments made. It ensures valid numeric inputs,
#' prevents overpayment, and supports both scalar and vectorized operations.
#'
#' @param actual_employeeLiability Numeric vector. Represents the actual tax liability of one or more employees.
#' @param payment_made Numeric vector. Corresponding payments already made by the employee(s).
#'
#' @return A numeric vector representing the outstanding tax liability after deducting payments.
#'
#' @details
#' This function validates that both inputs are numeric and non-negative. Additionally:
#'
#' - If any value in `payment_made` exceeds `actual_employeeLiability`, an error is thrown.
#' - The function supports vectorized operations, making it efficient for batch computations.
#'
#' @examples
#' # Example with single values (scalar inputs):
#' outstanding_liability(50000, 30000)  # Returns 20000
#'
#' # Example with multiple values (vectorized inputs):
#' actual_liabilities <- c(50000, 60000, 55000)
#' payments_made <- c(30000, 45000, 50000)
#' outstanding_liability(actual_liabilities, payments_made)
#' # Returns: c(20000, 15000, 5000)
#'
#' @export
outstanding_liability <- function(actual_employeeLiability, payment_made) {
  # Validate that both inputs are numeric
  if (!is.numeric(actual_employeeLiability) || !is.numeric(payment_made)) {
    stop("Error: Both actual_employeeLiability and payment_made must be numeric values.")
  }
  
  # Vectorized validation checks
  if (any(actual_employeeLiability < 0) || any(payment_made < 0)) {
    stop("Error: Values cannot be negative.")
  }
  
  if (any(payment_made > actual_employeeLiability)) {
    stop("Error: Payment made cannot exceed actual liability.")
  }
  
  # Calculate outstanding liability (vectorized arithmetic)
  expected_payment <- actual_employeeLiability - payment_made
  return(expected_payment)
}

