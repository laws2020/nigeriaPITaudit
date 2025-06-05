
#' Taxable Income
#'
#' This \code{taxable_income()} function calculates the **Taxable Income** by subtracting the total relief from the gross emolument.
#'
#' @details
#' Taxable income is the amount of income that will be subject to tax after all allowable
#' deductions and reliefs have been applied. It is a crucial figure for determining the tax liability.
#'
#' @param gross_salary Numeric. The total earnings before deductions computed by \code{gross_salary()}.
#' @param total_relief Numeric. The aggregate relief computed by \code{total_relief()}.
#'
#' @return A numeric value representing the taxable income. If deductions exceed gross salary, the result is 0.
#'
#' @examples
#' taxable_income(5000000, 1000000)  # Returns 4000000
#'
#' @export
taxable_income <- function(gross_salary, total_relief){
  return(gross_salary - total_relief)
}

