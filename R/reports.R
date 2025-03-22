#' Penalty and Interest for Late Tax Payment
#'
#' This \code{penalty_and_interest()} function calculates the penalty and interest charged on an unpaid tax amount when the tax payment is made after the due date.
#' Under Nigerian tax regulations, if a payment is late, a fixed penalty is applied based on the employer type (individual or corporate),
#' and interest accrues on the unpaid tax at a specified annual rate. The total liability is the sum of the original unpaid tax, the interest
#' accrued over the period of delay, and the fixed penalty.
#'
#' @details
#' The function works as follows:
#' \itemize{
#'   \item Both \code{due_date} and \code{payment_date} are converted to Date objects.
#'   \item If \code{payment_date} is on or before \code{due_date}, the function returns a message indicating that no penalty or interest applies.
#'   \item Otherwise, it computes the number of days overdue.
#'   \item An annual interest rate of 21% (0.21) is used, which is converted to a daily rate by dividing by 365.
#'   \item The interest amount is calculated by multiplying the unpaid tax by the daily interest rate and the number of days overdue.
#'   \item A fixed penalty is applied: 50,000 NGN for individuals and 500,000 NGN for corporate employers.
#'   \item The total liability is then calculated by summing the unpaid tax, the interest amount, and the penalty.
#' }
#'
#' @param unpaid_tax Numeric. The outstanding tax amount that has not been remitted.
#' @param due_date Character or Date. The due date for the tax payment. It must be in a format convertible by \code{as.Date()}.
#' @param payment_date Character or Date. The actual date on which the tax payment was made. It must be convertible to a Date.
#' @param employer_type Character. Specifies the type of employer, either "individual" or "corporate" (default is "corporate").
#' This determines the fixed penalty amount applied.
#'
#' @return A list with the following components:
#' \describe{
#'   \item{Unpaid_Tax}{The original unpaid tax amount.}
#'   \item{Days_Overdue}{The number of days by which the payment is late.}
#'   \item{Interest_Amount}{The computed interest on the unpaid tax over the overdue period (rounded to 2 decimal places).}
#'   \item{Penalty_Amount}{The fixed penalty amount based on the employer type.}
#'   \item{Total_Liability}{The sum of the unpaid tax, interest, and penalty, representing the total tax liability (rounded to 2 decimal places).}
#' }
#'
#' @examples
#' # Example 1: Payment made on time (no penalty or interest)
#' penalty_and_interest(1000000, "2024-01-31", "2024-01-31", employer_type = "corporate")
#'
#' # Example 2: Late payment by a corporate employer
#' penalty_and_interest(1000000, "2024-01-31", "2024-04-01", employer_type = "corporate")
#'
#' # Example 3: Late payment by an individual employer
#' penalty_and_interest(1000000, "2024-01-31", "2024-04-01", employer_type = "individual")
#'
#' @export
penalty_and_interest <- function(unpaid_tax, due_date, payment_date,
                                 employer_type = "corporate") {
  # Convert due_date and payment_date to Date objects
  due_date <- as.Date(due_date)
  payment_date <- as.Date(payment_date)

  # If payment is made on or before the due date, return a message indicating no penalty or interest
  if (payment_date <= due_date) {
    return("No penalty or interest. Payment was made on time.")
  }

  # Calculate the number of days the payment is overdue
  days_overdue <- as.numeric(difftime(payment_date, due_date, units = "days"))

  # Define the annual interest rate (21%) and calculate the daily interest rate
  annual_interest_rate <- 0.21
  daily_interest_rate <- annual_interest_rate / 365

  # Calculate the interest amount on the unpaid tax over the overdue period
  interest_amount <- unpaid_tax * daily_interest_rate * days_overdue

  # Determine the penalty amount based on the employer type: 50,000 NGN for individuals, 500,000 NGN for corporates
  penalty_amount <- ifelse(tolower(employer_type) == "individual", 50000, 500000)

  # Compute the total liability as the sum of the unpaid tax, interest amount, and penalty amount
  total_liability <- unpaid_tax + interest_amount + penalty_amount

  # Prepare and return the result as a list
  result <- list(
    Unpaid_Tax = unpaid_tax,
    Days_Overdue = days_overdue,
    Interest_Amount = round(interest_amount, 2),
    Penalty_Amount = penalty_amount,
    Total_Liability = round(total_liability, 2)
  )

  return(result)
}


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

