

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
