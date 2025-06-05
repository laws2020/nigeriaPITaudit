#' Penalty and Interest for Late PAYE Remittance (as per Finance Act 2020 and PITA)
#'
#' The \code{penalty_and_interest()} function computes the penalty and interest applicable to late remittance of Pay-As-You-Earn (PAYE) taxes,
#' in accordance with the Personal Income Tax Act (PITA) and the Finance Act 2020 of Nigeria.
#' Employers are required to remit deducted PAYE taxes on or before the 10th day of the month following the month of deduction.
#' Failure to remit within this timeline attracts a penalty and interest as specified in the law.
#'
#' @details
#' The Finance Act 2020, amending relevant sections of PITA, specifies that:
#' \itemize{
#'   \item Interest shall accrue at the prevailing Central Bank of Nigeria (CBN) minimum rediscount rate (currently approximated at 21%) on a daily basis until payment is made.
#' }
#'
#' The function performs the following operations:
#' \itemize{
#'   \item Converts \code{due_date} and \code{payment_date} to Date objects.
#'   \item If \code{payment_date} is on or before \code{due_date}, it returns a message indicating no penalty or interest applies.
#'   \item Otherwise, calculates the number of days overdue.
#'   \item Uses a daily interest rate derived from an annual rate of 21% (0.21 / 365).
#'   \item Computes the interest accrued on the unpaid tax for the number of days overdue.
#'   \item Calculates the total liability as the sum of the original tax, interest, and penalty.
#' }
#'
#' @param unpaid_tax Numeric. The outstanding PAYE tax amount that was not remitted on time.
#' @param due_date Character or Date. The statutory due date for the PAYE remittance (usually the 10th of the following month).
#' @param payment_date Character or Date. The actual remittance date. Must be convertible to a Date.
#'
#' @return A list containing:
#' \describe{
#'   \item{Unpaid_Tax}{Original unpaid PAYE amount.}
#'   \item{Days_Overdue}{Number of days past the due date.}
#'   \item{Interest_Amount}{Calculated interest on overdue amount (rounded to 2 decimal places).}
#'   \item{Penalty_Amount}{Penalty based on employer type (NGN 50,000 or NGN 500,000).}
#'   \item{Total_Liability}{Sum of tax, interest, and penalty (rounded to 2 decimal places).}
#' }
#'
#' @examples
#' # On-time remittance
#' penalty_and_interest(1000000, "2024-01-10", "2024-01-10")
#'
#' # Late remittance by corporate employer
#' penalty_and_interest(1000000, "2024-01-10", "2024-03-01")
#'
#' # Late remittance by individual employer
#' penalty_and_interest(1000000, "2024-01-10", "2024-03-01")
#' @export
penalty_and_interest <- function(unpaid_tax, due_date, payment_date) {
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

  # Define the penalty as 10% of the unpaid tax
  penalty_amount <- unpaid_tax * 0.10

  # Compute the total liability as the sum of the unpaid tax, interest amount, and penalty amount
  total_liability <- unpaid_tax + interest_amount + penalty_amount

  # Prepare and return the result as a list
  result <- list(
    Unpaid_Tax = unpaid_tax,
    Days_Overdue = days_overdue,
    Interest_Amount = round(interest_amount, 2),
    Penalty_Amount = round(penalty_amount, 2),
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

