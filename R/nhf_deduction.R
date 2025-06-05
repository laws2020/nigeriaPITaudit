
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

