#' Payroll Dataset for FMC
#'
#' `fmc2017` contains payroll data for employees at FMC. It includes basic salary, allowances, and other financial details.
#'
#' @format A data frame with `n` rows and `m` columns:
#' \describe{
#'  \item{S/N}{Numeric. Serial number of employee record.}
#'  \item{Name}{Character. Employee name.}
#'   \item{Staff_No}{Numeric. Employee ID.}
#'  \item{ConM/H}{Numeric. The employee's grade level.}
#'   \item{Basic_Salary}{Numeric. The employee's basic salary.}
#'   \item{Teaching_Allowance}{Numeric. Allowance for teaching staff.}
#'   \item{Salary_Arrears}{Numeric. Salary arrears, if applicable.}
#'   \item{other_allowances}{Numeric. Additional allowances.}
#'  \item{Overtime}{Numeric. Overtime payment.}
#'  \item{Shifting}{Numeric. Shift-related payments.}
#'   \item{specialist}{Numeric. Extra pay for specialist work.}
#'    \item{Hazard_Allowance}{Numeric. Extra pay for hazardous work.}
#'   \item{Call_Allowance}{Numeric. Allowance for call staff.}
#'   \item{Netpay}{Numeric. Employee's net salary after deductions.}
#' }
#' @source FMC Payroll System
#' @examples
#' data(fmc2017)
#' head(fmc2017)
"fmc2017"
