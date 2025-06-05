

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

