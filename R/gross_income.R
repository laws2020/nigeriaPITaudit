
#' Gross Income
#'
#' \code{gross_income()} computes the **Gross Income**, which is derived by subtracting tax-exempt
#' deductions (such as pension contributions, NHIS, and NHF) from the **Gross Salary**.
#'
#' The Gross Income serves as the basis for determining **taxable income** before the application of
#' reliefs and allowances.
#'
#' The formula for Gross Income is:
#'
#' \deqn{
#'   \text{Gross Income} = \text{Gross Salary} - (\text{Pension} + \text{NHIS} + \text{NHF})
#' }
#'
#' In R code, this is computed as:
#' \code{gross_income(gross_salary, pension, nhis, nhf)}
#'
#' @details
#' The **Finance Act 2020** redefines *gross income* in **Section 33(2) of the Personal Income Tax Act (PITA)** as:
#'
#' _"For the purposes of this Section, 'gross income' means income from all sources less all non-taxable income,
#' income on which no further tax is payable, tax-exempt items listed in paragraph (2) of the Sixth Schedule,
#' and all allowable business expenses and capital allowances."_
#'
#' This means that **Gross Income** is now calculated by subtracting:
#' - **Non-taxable income**
#' - **Tax-exempt items** (such as employee contributions to **pension schemes, NHIS, NHF, and life assurance premiums**)
#' - **Allowable business expenses and capital allowances**
#'
#' These deductions are applied **before computing the Consolidated Relief Allowance (CRA)**.
#'
#' @param gross_salary Numeric. The total earnings computed by \code{gross_salary()}.
#' @param pension Numeric. The pension contribution deduction.
#' @param nhis Numeric. The NHIS (National Health Insurance Scheme) deduction.
#' @param nhf Numeric. The NHF (National Housing Fund) deduction.
#'
#' @return A numeric value representing the **Gross Income** after tax-exempt deductions.
#'
#' @examples
#' # Example: Computing gross income after tax-exempt deductions
#' gross_income(2300000, 184000, 11500, 5750)  # Returns 2098750
#'
#'@seealso \code{\link{gross_salary}}, \code{\link{consolidated_relief}}
#' @export
gross_income <- function(gross_salary, pension, nhis, nhf) {
  # Deduct tax-exempt items from gross salary
  return(gross_salary - (pension + nhis + nhf))
}


