#' Payroll Dataset for FMC
#'
#' `fmc2017` contains payroll data for employees at FMC. It includes basic salary, allowances, and other financial details.
#'
#' @format A data frame with `n` rows and `m` columns:
#' \describe{
#'   \item{Staff_No}{Numeric. Employee ID.}
#'   \item{Name}{Character. Employee name.}
#'   \item{Basic_Salary}{Numeric. The employee's basic salary.}
#'   \item{ConM/H}{Numeric. The employee's grade level.}
#'   \item{Call_Allowance}{Numeric. Allowance for call staff.}
#'   \item{Teaching_Allowance}{Numeric. Allowance for teaching staff.}
#'   \item{Salary_Arrears}{Numeric. Salary arrears, if applicable.}
#'   \item{other_allowances}{Numeric. Additional allowances.}
#'   \item{Overtime}{Numeric. Overtime payment.}
#'   \item{Shifting}{Numeric. Shift-related payments.}
#'   \item{Speacilist}{Numeric. Extra pay for specialist work.}  # Check if spelling is intentional
#'   \item{Hazard_Allowance}{Numeric. Extra pay for hazardous work.}
#'   \item{S/N}{Numeric. Serial number of employee record.}
#'   \item{Netpay}{Numeric. Employee's net salary after deductions.}
#' }
#' @source FMC Payroll System
#' @examples
#' data(fmc2017)
#' head(fmc2017)
"fmc2017"
