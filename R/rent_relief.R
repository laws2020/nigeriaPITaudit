
#' Rent Relief Allowance
#'
#' \code{rent_relief()} Computes the Rent Relief Allowance (RRA) under Nigeria's proposed tax reform 2024.
#' Taxpayers can deduct either **₦200,000** or **20% of their annual rent**, whichever is lower,
#' from their taxable income.
#'
#' @param rent_paid Numeric. The total annual rent paid by the taxpayer (in Naira).
#'
#' @return Numeric. The eligible Rent Relief deduction (in Naira).
#'
#' @details
#' The Nigerian tax reform bill introduces the Rent Relief Allowance (RRA), replacing the
#' Consolidated Relief Allowance (CRA). The relief is capped at **₦200,000**, ensuring that
#' taxpayers paying higher rent do not exceed this deduction limit.
#'
#' The function ensures that only **the lesser value** between 20% of rent and ₦200,000 is deducted.
#'
#' @note
#' - If rent is **below ₦1,000,000**, the deduction is **20% of rent**.
#' - If rent is **₦1,000,000 or more**, the maximum deduction is **₦200,000**.
#'
#' @examples
#' # Example 1: Rent below ₦1M (20% is lower)
#' rent_relief(500000)  # Returns 100000 (20% of 500K)
#'
#' # Example 2: Rent above ₦1M (capped at 200K)
#' rent_relief(2000000) # Returns 200000 (capped)
#'
#' @references
#' Federal Inland Revenue Service (FIRS), Nigeria. (2024). *Proposed Personal Income Tax Reform Bill*.
#' Retrieved from: <https://www.firs.gov.ng>
#'
#' @export
rent_relief <- function(rent_paid) {
  return(pmin(200000, 0.20 * rent_paid))  # Lower of ₦200,000 or 20% of rent
}
