
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
