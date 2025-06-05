
#' Consolidated Relief Allowance (CRA)
#'
#' \code{consolidated_relief()} computes the **Consolidated Relief Allowance (CRA)**,
#' a key tax relief under Nigeria’s **Personal Income Tax Act (PITA) 2020**.
#'
#' The CRA is designed to reduce the taxable income of an individual, ensuring
#' that a portion of their earnings is exempt from taxation before applying the income tax rates.
#'
#' @details
#' According to **Section 33(1) of PITA as amended by the Finance Act 2020**, the Consolidated Relief Allowance (CRA) is defined as:
#'
#' _"There shall be allowed a consolidated relief allowance of ₦200,000 subject to a minimum
#' of 1% of gross income, whichever is higher, plus 20% of the gross income.
#' The balance shall be taxable in accordance with the income table in the Sixth Schedule to this Act."_
#'
#' This means the CRA is computed using the formula:
#'
#' \deqn{
#'   CRA =
#'   \begin{cases}
#'   \text{Gross Income} \times 20\% + 200,000, & \text{if } 1\% \times \text{Gross Income} \leq 200,000 \\
#'   \text{Gross Income} \times 20\% + 1\% \times \text{Gross Income}, & \text{if } 1\% \times \text{Gross Income} > 200,000
#'   \end{cases}
#' }
#'
#' This logic can also be expressed in **Excel** as:
#'
#' \code{CRA = IF(gross_income * 1% > 200000, gross_income * 1% + gross_income * 20%, 200000 + gross_income * 20%)}
#'
#' In R, this is implemented using the \code{ifelse()} function.
#'
#' @param gross_income Numeric. The income on which CRA is computed, typically the result of \code{gross_income()}.
#' @param period Character. The period for which CRA is calculated. Accepts `"yearly"` (default) or `"monthly"`.
#'
#' @return A numeric value representing the **Consolidated Relief Allowance (CRA)**.
#'
#' @examples
#' # Example 1: If 1% of gross income is greater than 200,000 Naira
#' consolidated_relief(5000000)
#' # Returns: (1% * 5000000) + (20% * 5000000) = 50,000 + 1,000,000 = 1,050,000
#'
#' # Example 2: If 1% of gross income is less than or equal to 200,000 Naira
#' consolidated_relief(2000000)
#' # Returns: 200,000 + (20% * 2000000) = 200,000 + 400,000 = 600,000
#'
#' # Example 3: Compute monthly CRA for a gross income of 3,600,000 Naira
#' consolidated_relief(3600000, "monthly")
#' # 1% of 3,600,000 = 36,000 (greater than 16,666.67, so we take 36,000)
#' # Monthly CRA = (36,000 + 20% * 3,600,000) = 36,000 + 720,000 = 756,000
#' @seealso \code{\link{gross_income}}, \code{\link{pension_deduction}},
#' \code{\link{nhf_deduction}}, \code{\link{nhis_deduction}}
#' @export
consolidated_relief <- function(gross_income, period = 'yearly') {
  if(!is.numeric(gross_income) || any(gross_income < 0)) {
    stop("Gross Income must be a positive numeric value.")
  }

  # Annual base relief and monthly equivalent
  base_relief_yearly <- 200000
  base_relief_monthly <- (base_relief_yearly) / 12  # 16,666.67

  # Calculate relief based on the period
  if (period == 'yearly') {
    relief <- ifelse(0.01 * gross_income > base_relief_yearly,
                     (0.01 * gross_income) + (0.2 * gross_income),
                     base_relief_yearly + (0.2 * gross_income))

  } else if (period == 'monthly') {
    # Here, base_relief_monthly is used directly for monthly calculations
    relief <- ifelse(0.01 * gross_income > base_relief_monthly,
                     (0.01 * gross_income) + (0.2 * gross_income),
                     base_relief_monthly + (0.2 * gross_income))

  } else {
    stop("Invalid period. Choose either 'yearly' or 'monthly'")
  }

  # Return the result rounded to 2 decimal places
  return(round(relief, 2))
}

