#' Gross Salary for Employees
#'
#' \code{gross_salary()} calculates the total earnings from employment before applying deductions for tax-exempt items.
#' It sums up all salary components (e.g., basic salary, allowances, bonuses, etc.) before any deductions are applied.
#'
#' The function accepts multiple numeric vectors representing different components of an employee's earnings
#' and returns their row-wise sum. If any non-numeric values are provided, the function throws an error.
#'
#' The formula for Gross Salary is given by:
#'
#' \deqn{
#'   \text{Gross Salary} = \text{Basic Salary} + \text{Housing} + \text{Transport} + \text{Utility} + \text{Meal} + \ldots
#' }
#'
#' @details
#' _"Gross salary" is defined as:_
#' _"wages, salaries, allowances (including benefits in kind), gratuities,
#'  superannuation, and any other incomes derived solely from employment."_
#'
#' The \code{gross_salary()} function is fundamental in payroll calculations and serves as a base for computing
#' deductions, taxable income, and other salary-related computations within the `nigeriaPITaudit` package.
#'
#' It supports missing values (`NA`) by ignoring them during computation. If all values in a row are `NA`, the function returns `0` for that row.
#'
#' @param ... Numeric vectors representing different components of an employee's earnings (e.g., Basic Salary, Allowances, Bonuses).
#'
#' @return A numeric vector containing the computed gross emolument for each employee.
#'
#' @note
#' - All input vectors must be numeric and of the same length (i.e., corresponding to the same number of employees).
#' - The function ignores `NA` values while summing components.
#' - If all values in a row are `NA`, the function returns `0` for that row.
#'
#' @examples
#' # Example dataset
#' df <- data.frame(
#'   Employee = c("John", "Bassey", "James", "Abigail", "Ruth"),
#'   BasicSalary = c(120000, 110000, 115000, 90000, 130000),
#'   RiskAllowance = c(100000, 120000, 13400, 150000, 189999),
#'   Bonus = c(5000, NA, 7000, 3000, 10000)
#' )
#'
#' # Compute Gross Salary
#' df$GrossSalary <- gross_salary(df$BasicSalary, df$RiskAllowance, df$Bonus)
#'
#' # View the updated dataset
#' print(df)
#'
#' # Example 1: Sum of basic salary and two allowances
#' gross_salary(500000, 200000, 100000)  # Returns 800000
#'
#' # Example 2: Handling NA values (they are ignored)
#' gross_salary(3000000, NA, 500000)  # Returns 3500000
#'
#' @seealso \code{\link{gross_income}}
#'
#' @keywords taxation finance payroll salary income
#' @export
gross_salary <- function(...) {
  # Capture inputs as a list
  cols <- list(...)

  # Validate that all inputs are numeric (excluding NAs)
  if (!all(sapply(cols, function(col) is.numeric(col) || all(is.na(col))))) {
    stop("All inputs must be numeric or NA.")
  }

  # Check for negative values
  if (any(sapply(cols, function(col) any(col < 0, na.rm = TRUE)))) {
    stop("Salary and bonus cannot be negative.")
  }

  # Ensure all vectors are the same length
  lengths <- sapply(cols, length)
  if (length(unique(lengths)) > 1) {
    stop("All input vectors must have the same length.")
  }

  # Compute row-wise sums while ignoring NA values
  gross_sum <- rowSums(do.call(cbind, cols), na.rm = TRUE)

  return(gross_sum)  # Return computed gross salaries
}

