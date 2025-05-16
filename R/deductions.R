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



#' Pension Deduction
#'
#' \code{pension_deduction()} computes the pension deduction from the gross salary using a default rate of 8% (0.08).
#' The function ensures consistent computation by leveraging the \code{tax_exemption()} function.
#'
#' @details
#' In many organizations, pension contributions are a fixed percentage of an employee's gross earnings.
#' This function serves as a wrapper around \code{tax_exemption()} to apply the standard pension rate.
#' If a custom rate is provided, it is automatically converted if necessary.
#'
#' \deqn{
#'   \text{Pension Deduction} = \text{Gross Salary} \times \text{Rate}
#' }
#'
#' @param gross_salary Numeric. The total gross earnings before deductions.
#' @param rate Numeric or character. The pension deduction rate (default is 8%, i.e., 0.08).
#' Can be provided as:
#'   \itemize{
#'     \item A decimal proportion (e.g., 0.08 for 8%).
#'     \item A whole number percentage (e.g., 8 for 8%).
#'     \item A percentage string (e.g., "8%").
#'   }
#'
#' @return A numeric value representing the pension deduction amount.
#'
#' @examples
#' # Default pension deduction (8%)
#' pension_deduction(2000000)      # Returns 160000
#'
#' # Custom pension deduction (10%)
#' pension_deduction(2000000, 10)   # Returns 200000
#'
#' @seealso \code{\link{tax_exemption}}
#' @export
pension_deduction <- function(gross_salary, rate = 0.08) {
  tax_exemption(gross_salary, rate)
}


#' National Housing Fund (NHF) Deduction
#'
#' \code{nhf_deduction()} Computes the NHF deduction from the basic salary using a default rate of 2.5% (0.025).
#' The function ensures consistent computation by utilizing \code{tax_exemption()}.
#'
#' @details
#' The National Housing Fund (NHF) deduction is a statutory contribution aimed at housing development.
#' Employees contribute a fixed percentage of their gross emolument to support housing schemes.
#' This function applies the standard NHF rate unless a custom rate is provided.
#'
#' \deqn{
#'   \text{NHF Deduction} = \text{Gross Salary} \times \text{Rate}
#' }
#'
#' @param basic_salary Numeric. The total basic salary earnings before deductions.
#' @param rate Numeric or character. The NHF deduction rate (default is 2.5%, i.e., 0.025).
#' Can be provided as:
#'   \itemize{
#'     \item A decimal proportion (e.g., 0.025 for 2.5%).
#'     \item A whole number percentage (e.g., 2.5 for 2.5%).
#'     \item A percentage string (e.g., "2.5%").
#'   }
#'
#' @return A numeric value representing the NHF deduction amount.
#'
#' @examples
#' # Default NHF deduction (2.5%)
#' nhf_deduction(2000000) # Returns 50000
#'
#' # Custom NHF deduction (3%)
#' nhf_deduction(2000000, 3)  # Returns 60000
#'
#' @seealso \code{\link{tax_exemption}}
#' @export
nhf_deduction <- function(basic_salary, rate = 0.025) {
  tax_exemption(basic_salary, rate)
}


#' National Health Insurance Scheme (NHIS) Deduction
#'
#' This function calculates the NHIS deduction from the gross salary using a
#' default rate of 5% (0.05). It calls the \code{tax_exemption()} function to apply
#' the deduction rate consistently.
#'
#' @details
#' The NHIS deduction is mandated to contribute towards employee health insurance
#' in Nigeria. This function computes the deduction amount based on the specified rate
#' (defaulting to 5%), with automatic conversion of percentage inputs to a proportion.
#'
#' @param gross_salary Numeric. The total gross earnings before deductions.
#' @param rate Numeric. The NHIS deduction rate (default is 0.05, representing 5%).
#' It can be provided as a percentage (e.g., 5).
#'
#' @return A numeric value representing the NHIS deduction amount.
#'
#' @examples
#' # Default NHIS deduction (5%)
#' nhis_deduction(2000000)        # Returns 100000
#'
#' # Custom NHIS deduction (6%)
#' nhis_deduction(2000000, 6)       # Returns 120000 (after conversion)
#'
#' @export
nhis_deduction <- function(gross_salary, rate = 0.05) {
  tax_exemption(gross_salary, rate)
}
