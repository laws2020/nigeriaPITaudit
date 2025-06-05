
#' Employee Tax Liability (PITA 2020)
#'
#' The \code{employee_tax_liability()} function computes the **Personal Income Tax (PAYE)** liability for an individual
#' based on Nigeria’s **Personal Income Tax Act (PITA) 2020** graduated tax brackets. For
#' more details, refer to the **Finance Act 2020** document.
#'
#' @details
#' The tax calculation follows Nigeria's progressive tax system:
#' \enumerate{
#'   \item Income below 300,000 NGN is taxed at **1%**.
#'   \item The first 300,000 NGN is taxed at **7%**.
#'   \item The next 300,000 NGN is taxed at **11%**.
#'   \item The next 500,000 NGN is taxed at **15%**.
#'   \item The next 500,000 NGN is taxed at **19%**.
#'   \item The next 1,600,000 NGN is taxed at **21%**.
#'   \item Any income above 3,200,000 NGN is taxed at **24%**.
#' }
#'
#' **Note:** According to the **Finance Act 2020**, employees earning minimum wage
#' are **exempt** from PAYE tax.
#'
#' @param taxable_income Numeric. The taxable income after applying all allowable deductions.
#' @param period Character. Specifies whether the tax is calculated on a **yearly** or **monthly** basis.
#'               Default is **"yearly"**.
#'
#' @return A numeric value representing the total PAYE tax liability.
#'
#' @examples
#' # Example: Employee with a taxable income of 4,500,000 NGN (Yearly)
#' employee_tax_liability(4500000)
#'
#' # Example: Employee with a taxable income of 375,000 NGN (Monthly)
#' employee_tax_liability(375000, period = "monthly")
#'
#' @export

employee_tax_liability <- function(taxable_income, period = "monthly") {
  # Validate input
  if (!is.numeric(taxable_income) || any(is.na(taxable_income)) || any(taxable_income < 0)) {
    stop("Taxable income must be a positive numeric value.")
  }

  # Define tax brackets and rates based on the period
  if (period == "monthly") {
    tax_brackets <- c(300000, 300000, 500000, 500000, 1600000, 3200000) # Yearly bands
    tax_rates <- c(0.07, 0.11, 0.15, 0.19, 0.21, 0.24) # Yearly tax rates
  } else if (period == "yearly") {
    tax_brackets <- c(25000, 25000, 41667, 41667, 133333, 266667) # Monthly bands
    tax_rates <- c(0.07, 0.11, 0.15, 0.19, 0.21, 0.24) # Monthly tax rates
  } else {
    stop("Invalid period. Choose either 'yearly' or 'monthly'.")
  }

  # Initialize output vector
  total_tax <- rep(0, length(taxable_income))

  # Apply progressive tax rates
  for (i in seq_along(tax_brackets)) {
    taxable_amount <- pmin(taxable_income, tax_brackets[i])
    total_tax <- total_tax + taxable_amount * tax_rates[i]
    taxable_income <- taxable_income - taxable_amount
  }

  # If there's any remaining income above the last bracket, tax it at 24%
  total_tax <- total_tax + pmax(taxable_income, 0) * 0.24

  return(round(total_tax, 2)) # Return tax liability rounded to 2 decimal places
}
