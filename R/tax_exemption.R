#' Tax-Exempt Deductions
#'
#'  \code{tax_exemption()} calculates tax-exempt deductions based on a specified rate and gross salary.
#' This function serves as a foundation for various statutory deductions such as pension, NHF, and NHIS.
#'
#' @details
#' The \code{tax_exemption()} function determines the amount that qualifies for tax exemption
#' by applying a specified deduction rate to the gross salary (total earnings before deductions).
#' The function allows flexibility in how the deduction rate is provided.
#'
#' Accepted formats for \code{rate}:
#' \itemize{
#'   \item **Proportion (Decimal Form)**: e.g., 0.08 for 8%.
#'   \item **Whole Number Percentage**: e.g., 8 for 8%.
#'   \item **Percentage String**: e.g., "8%" for 8%.
#' }
#'
#' If the rate is given as a whole number or percentage string (e.g., "8%"),
#' the function converts it to a decimal proportion by dividing by 100.
#'
#' This function is designed to be reused in other deduction calculations such as:
#' \code{\link{pension_deduction}}, \code{\link{nhf_deduction}}, and \code{\link{nhis_deduction}}.
#'
#' @param gross_salary Numeric. The total gross earnings before deductions.
#' @param rate Numeric or character. The deduction rate, which can be:
#'   \itemize{
#'     \item A decimal proportion (e.g., 0.08 for 8%).
#'     \item A whole number percentage (e.g., 8 for 8%).
#'     \item A percentage string (e.g., "8%").
#'   }
#'   If given as a percentage (whole number or string), it is converted to a proportion.
#'
#' @return A numeric value representing the total tax-exempt deduction.
#'
#' @examples
#' # Using a proportion (8% as 0.08)
#' tax_exemption(2000000, 0.08)   # Returns 160000
#'
#' # Using a whole number percentage (8%)
#' tax_exemption(2000000, 8)      # Also returns 160000
#'
#' # Using a percentage string ("8%")
#' tax_exemption(2000000, "8%")   # Also returns 160000
#'
#' # Using a different percentage (12%)
#' tax_exemption(2000000, "12%")  # Returns 240000
#'
#' @seealso \code{\link{pension_deduction}}, \code{\link{nhf_deduction}}, \code{\link{nhis_deduction}}
#' @export

tax_exemption <- function(gross_salary, rate) {
  # Ensure gross_salary is numeric
  if (!is.numeric(gross_salary)) {
    stop("Error: gross_salary must be a numeric vector.")
  }

  # Ensure there are no NA values in gross_salary
  if (any(is.na(gross_salary))) {
    stop("Error: gross_salary contains NA values.")
  }

  # Convert rate to numeric if given as a percentage string
  if (is.character(rate)) {
    rate <- as.numeric(gsub("%", "", rate)) / 100  # Convert "8%" to 0.08
  }

  # Ensure rate is numeric and properly vectorized
  if (!is.numeric(rate) || any(is.na(rate)) || any(rate < 0)) {
    stop("Error: rate must be a positive numeric value.")
  }

  # Handle cases where rate is a single value but gross_salary is a vector
  if (length(rate) == 1) {
    rate <- rep(rate, length(gross_salary))  # Expand rate to match length of gross_salary
  }

  # Perform element-wise multiplication
  return(gross_salary * rate)
}

