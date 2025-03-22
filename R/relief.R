
#' Consolidated Relief Allowance (CRA)
#'
#' \code{consolidated_relief()} computes the **Consolidated Relief Allowance (CRA)**,
#' a key tax relief under Nigeria’s **Personal Income Tax Act (PITA) 2020**.
#'
#' The CRA is designed to reduce the taxable income of an individual, ensuring
#' that a portion of their earnings is exempt from taxation before applying the income tax rates.
#'
#' @details
#' According to **Section 33(2) of PITA 2020**, the Consolidated Relief Allowance (CRA) is defined as:
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
consolidated_relief <- function(gross_income, period = "yearly") {
  # Validate input
  if (!is.numeric(gross_income) || any(gross_income < 0)) {
    stop("Gross income must be a positive numeric value.")
  }

  # Define base relief values
  base_relief_yearly <- 200000
  base_relief_monthly <- base_relief_yearly / 12  # ₦16,666.67

  # Determine base relief based on period
  if (period == "yearly") {
    relief <- ifelse(0.01 * gross_income > base_relief_yearly,
                     0.01 * gross_income + (0.2 * gross_income),
                     base_relief_yearly + (0.2 * gross_income))
  } else if (period == "monthly") {
    relief <- ifelse(0.01 * gross_income > base_relief_monthly,
                     0.01 * gross_income + (0.2 * gross_income),
                     base_relief_monthly + (0.2 * gross_income))
  } else {
    stop("Invalid period. Choose either 'yearly' or 'monthly'.")
  }

  return(round(relief, 2))  # Rounded to 2 decimal places
}


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


#' Total Relief
#'
#' \code{total_relief()} computes the **Total Relief**, which is the sum of all tax-exempt
#' allowances, including the **Consolidated Relief Allowance (CRA)**, pension contributions,
#' **National Housing Fund (NHF)** deductions, and **National Health Insurance Scheme (NHIS)** deductions.
#'
#' @details
#' **Legal Basis:**
#' According to **Section 33(2) of the Personal Income Tax Act (PITA) 2020**,
#' taxpayers are entitled to various reliefs, including:
#' \enumerate{
#'   \item \strong{Consolidated Relief Allowance (CRA)} – Computed as per PITA Section 33(2).
#'   \item \strong{Pension Contributions} – Recognized as a tax-deductible item under the Pension Reform Act.
#'   \item \strong{National Housing Fund (NHF) Contributions} – Exempt under the NHF Act.
#'   \item \strong{National Health Insurance Scheme (NHIS) Contributions} – Exempt per the NHIS Act.
#' }
#'
#' **Computation Formula:**
#' \deqn{
#'   \text{Total Relief} = \text{CRA} + \text{Pension} + \text{NHF} + \text{NHIS}
#' }
#'
#' The **Total Relief** is deducted from the **Gross Income** to determine the **Taxable Income**,
#' which is then subject to personal income tax rates.
#'
#' **Excel Equivalent Formula:**
#' \code{Total_Relief = CRA + Pension + NHF + NHIS}
#'
#' @param cra_value Numeric. The Consolidated Relief Allowance, computed by \code{consolidated_relief()}.
#' @param pension Numeric. The pension deduction amount.
#' @param nhf Numeric. The NHF (National Housing Fund) deduction.
#' @param nhis Numeric. The NHIS (National Health Insurance Scheme) deduction.
#'
#' @return A numeric value representing the **Total Relief** amount.
#'
#' @examples
#' # Example Calculation
#' total_relief(1500000, 180000, 5750, 11500)  # Returns the sum of all reliefs
#'
#' @export
total_relief <- function(cra_value, pension, nhf, nhis) {
  # Sum all tax-exempt allowances to compute total relief
  total_relief <- (cra_value + pension + nhf + nhis)
  return(total_relief)
}
