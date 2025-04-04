#' Compute Nigeria's Company Income Tax (CIT) and Education Tax (EDT) for multiple years
#'
#' This function determines the CIT rate based on turnover, calculates
#' the actual CIT liability based on taxable profit, and computes
#' the Education Tax (EDT) for each year.
#'
#' @param turnover Numeric vector. The company's annual turnover(s) in Naira.
#' @param taxable_profit Numeric vector. The taxable profit(s) for the company.
#'
#' @return A data frame containing:
#'   - `Year`: The index representing each year.
#'   - `Turnover`: The company's turnover.
#'   - `Taxable_Profit`: The taxable profit.
#'   - `CIT_Rate`: The applicable tax rate (0%, 20%, or 30%).
#'   - `CIT_Amount`: The actual CIT payable.
#'   - `EDT_Amount`: The Education Tax (2% of taxable profit).
#'
#' @examples
#' compute_CIT(c(120e6, 50e6, 20e6), c(50e6, 20e6, 5e6))
#'
#' @export
compute_CIT <- function(turnover, taxable_profit) {

  # Ensure input vectors are the same length
  if (length(turnover) != length(taxable_profit)) {
    stop("Error: Turnover and taxable profit must have the same length.")
  }

  # Validate inputs
  if (any(turnover < 0) || any(taxable_profit < 0)) {
    stop("Invalid input: Turnover and taxable profit must be non-negative.")
  }

  # Determine CIT rate for each year
  CIT_rate <- ifelse(turnover > 100e6, 30,
                     ifelse(turnover >= 25e6, 20, 0))

  # Compute CIT amount
  CIT_amount <- (CIT_rate / 100) * taxable_profit

  # Compute Education Tax (EDT) amount
  EDT_amount <- 0.02 * taxable_profit

  # Return results as a data frame
  result <- data.frame(
    Year = seq_along(turnover),
    Turnover = turnover,
    Taxable_Profit = taxable_profit,
    CIT_Rate = CIT_rate,
    CIT_Amount = CIT_amount,
    EDT_Amount = EDT_amount
  )

  return(result)
}







library(readxl)    # For Excel sheets
library(pdftools)  # For PDF bank statements & invoices
library(tidyverse) # For data wrangling
library(stringr)   # For text extraction from documents

#' Extract Revenue from Invoices & Receipts
#'
#' @param file_path Path to invoices/receipts file (Excel, CSV, or PDF)
#' @return Total Revenue (Turnover)
extract_revenue <- function(file_path) {
  file_ext <- tools::file_ext(file_path)

  if (file_ext %in% c("xls", "xlsx")) {
    df <- read_excel(file_path, sheet = "Invoices")
    revenue <- sum(df$Amount)
  } else if (file_ext == "csv") {
    df <- read_csv(file_path)
    revenue <- sum(df$Amount)
  } else if (file_ext == "pdf") {
    text <- pdf_text(file_path) %>% paste(collapse = " ")
    revenue <- as.numeric(str_extract(text, "Total Revenue:\\s+([0-9,]+)") %>% str_replace_all(",", ""))
  } else {
    stop("Unsupported file format!")
  }
  return(revenue)
}

#' Extract Expenses from Bank Statements
#'
#' @param file_path Path to bank statement (Excel, CSV, or PDF)
#' @return Total expenses
extract_expenses <- function(file_path) {
  file_ext <- tools::file_ext(file_path)

  if (file_ext %in% c("xls", "xlsx")) {
    df <- read_excel(file_path, sheet = "Bank Transactions")
    expenses <- sum(df$Amount[df$Type == "Debit"])
  } else if (file_ext == "csv") {
    df <- read_csv(file_path)
    expenses <- sum(df$Amount[df$Type == "Debit"])
  } else if (file_ext == "pdf") {
    text <- pdf_text(file_path) %>% paste(collapse = " ")
    expenses <- as.numeric(str_extract(text, "Total Expenses:\\s+([0-9,]+)") %>% str_replace_all(",", ""))
  } else {
    stop("Unsupported file format!")
  }
  return(expenses)
}

#' Extract Net Profit from Profit & Loss Statement
#'
#' @param file_path Path to profit & loss statement
#' @return Net Profit
extract_net_profit <- function(file_path) {
  file_ext <- tools::file_ext(file_path)

  if (file_ext %in% c("xls", "xlsx")) {
    df <- read_excel(file_path, sheet = "Profit Loss")
    net_profit <- df$Amount[df$Account == "Net Profit"]
  } else if (file_ext == "csv") {
    df <- read_csv(file_path)
    net_profit <- df$Amount[df$Account == "Net Profit"]
  } else if (file_ext == "pdf") {
    text <- pdf_text(file_path) %>% paste(collapse = " ")
    net_profit <- as.numeric(str_extract(text, "Net Profit:\\s+([0-9,]+)") %>% str_replace_all(",", ""))
  } else {
    stop("Unsupported file format!")
  }
  return(net_profit)
}

#' Extract Payroll Costs
#'
#' @param file_path Path to payroll records
#' @return Total payroll cost
extract_payroll_cost <- function(file_path) {
  file_ext <- tools::file_ext(file_path)

  if (file_ext %in% c("xls", "xlsx")) {
    df <- read_excel(file_path, sheet = "Payroll")
    payroll_cost <- sum(df$Salary)
  } else if (file_ext == "csv") {
    df <- read_csv(file_path)
    payroll_cost <- sum(df$Salary)
  } else {
    stop("Unsupported file format!")
  }
  return(payroll_cost)
}

#' Compute Turnover & Taxable Profit from Financial Reports
#'
#' @param invoice_file Path to invoice file
#' @param bank_statement_file Path to bank statement
#' @param profit_loss_file Path to profit & loss statement
#' @param payroll_file Path to payroll records
#' @return Dataframe with computed turnover & taxable profit
compute_financial_summary <- function(invoice_file, bank_statement_file, profit_loss_file, payroll_file) {
  revenue <- extract_revenue(invoice_file)
  expenses <- extract_expenses(bank_statement_file)
  net_profit <- extract_net_profit(profit_loss_file)
  payroll_cost <- extract_payroll_cost(payroll_file)

  taxable_profit <- net_profit - payroll_cost

  return(data.frame(Turnover = revenue, Taxable_Profit = taxable_profit))
}

#' Compute CIT & EDT using Turnover & Taxable Profit
#'
#' @param turnover Total revenue
#' @param taxable_profit Profit subject to tax
#' @return Computed CIT & EDT
compute_CIT <- function(turnover, taxable_profit) {
  cit_rate <- ifelse(turnover > 100e6, 0.30, ifelse(turnover >= 25e6, 0.20, 0.00))
  cit_liability <- taxable_profit * cit_rate
  edt_liability <- taxable_profit * 0.02

  return(data.frame(CIT = cit_liability, EDT = edt_liability))
}

# Example Usage
invoice_file <- "Invoices.xlsx"
bank_statement_file <- "Bank_Statements.xlsx"
profit_loss_file <- "Profit_Loss.xlsx"
payroll_file <- "Payroll.xlsx"

financial_summary <- compute_financial_summary(invoice_file, bank_statement_file, profit_loss_file, payroll_file)
cit_results <- compute_CIT(financial_summary$Turnover, financial_summary$Taxable_Profit)

print(financial_summary)
print(cit_results)



# Extract specific financial data
revenue <- extract_revenue("Invoices.xlsx")
expenses <- extract_expenses("Bank_Statements.xlsx")
net_profit <- extract_net_profit("Profit_Loss.xlsx")
payroll_cost <- extract_payroll_cost("Payroll.xlsx")

# Compute taxable profit
taxable_profit <- net_profit - payroll_cost

# Compute CIT & EDT separately
cit_results <- compute_CIT(revenue, taxable_profit)

print(cit_results)




#' Compute Company Income Tax (CIT)
#'
#' This function calculates the Company Income Tax (CIT) based on the given profit and tax rate.
#'
#' @param profit Numeric. The taxable profit of the company.
#' @param rate Numeric. The CIT rate (default is 30%).
#'
#' @return Numeric. The computed CIT liability.
#'
#' @examples
#' compute_cit(50000000)  # Standard CIT at 30%
#' compute_cit(50000000, 25)  # CIT at 25%
compute_cit <- function(profit, rate = 30) {
  if (!is.numeric(profit) || profit < 0) stop("Profit must be a non-negative numeric value.")
  if (!is.numeric(rate) || rate <= 0) stop("Tax rate must be a positive numeric value.")
  return(round(profit * (rate / 100), 2))
}




#' Look up CIT rate based on company size
#' @param company_size Character. Either 'small', 'medium', or 'large'.
#' @return Numeric. The applicable CIT rate.
#' @examples
#' cit_rate_lookup("small")  # Returns 20
cit_rate_lookup <- function(company_size) {
  rates <- list(small = 20, medium = 25, large = 30)
  return(rates[[tolower(company_size)]] %||% stop("Invalid company size."))
}

#' Check if company is subject to minimum tax
#' @param revenue Numeric. The total revenue.
#' @param net_assets Numeric. The net assets value.
#' @param threshold Numeric. The threshold for minimum tax (default: 25M NGN).
#' @return Logical. TRUE if company is subject to minimum tax.
#' @examples
#' minimum_tax_check(30000000, 5000000)  # Returns TRUE
minimum_tax_check <- function(revenue, net_assets, threshold = 25e6) {
  return(revenue < threshold && net_assets <= 0)
}

#' List of CIT exempt income categories
#' @return Character vector of exempt income sources.
#' @examples
#' cit_exempt_income()
cit_exempt_income <- function() {
  return(c("Dividends from companies in tax-free zones", "Interest on government bonds", "Export profits"))
}

#' Deduct tax credit from CIT liability
#' @param cit Numeric. The computed CIT liability.
#' @param tax_credit_amount Numeric. The available tax credit.
#' @return Numeric. The adjusted CIT after tax credit deduction.
#' @examples
#' tax_credit_deduction(10000000, 2000000)  # Returns 8,000,000 NGN
tax_credit_deduction <- function(cit, tax_credit_amount) {
  return(max(0, cit - tax_credit_amount))
}

#' Check CIT threshold for eligibility
#' @param annual_turnover Numeric. The total annual revenue.
#' @param threshold Numeric. The turnover threshold (default: 25M NGN).
#' @return Logical. TRUE if company is eligible for standard CIT rates.
#' @examples
#' cit_threshold_check(50000000)  # Returns TRUE
cit_threshold_check <- function(annual_turnover, threshold = 25e6) {
  return(annual_turnover > threshold)
}

#' Generate a summary of CIT computations
#' @param data Data frame. A dataset containing company financials.
#' @param period Character. Either 'annual' (default) or 'quarterly'.
#' @return Data frame summarizing CIT.
#' @examples
#' cit_summary(data.frame(company=c("A", "B"), profit=c(50000000, 20000000)))
cit_summary <- function(data, period = "annual") {
  data$CIT <- compute_cit(data$profit)
  return(data)
}

#' Check CIT filing deadline
#' @param date Date. The CIT filing date.
#' @return Logical. TRUE if filing is on time.
#' @examples
#' cit_filing_deadline_check(Sys.Date())
cit_filing_deadline_check <- function(date) {
  return(date <= as.Date("2025-06-30"))
}

#' Generate a CIT report
#' @param data Data frame. The financial dataset.
#' @param period Character. Either 'annual' or 'quarterly'.
#' @return Data frame with computed CIT data.
#' @examples
#' generate_cit_report(data.frame(company=c("A"), profit=c(50000000)))
generate_cit_report <- function(data, period = "annual") {
  return(cit_summary(data, period))
}

#' Reconcile expected and actual CIT payments
#' @param expected_tax Numeric. The expected CIT liability.
#' @param actual_tax_paid Numeric. The actual CIT paid.
#' @return Numeric. The outstanding CIT balance.
#' @examples
#' reconcile_cit(10000000, 8000000)  # Returns 2,000,000 NGN
reconcile_cit <- function(expected_tax, actual_tax_paid) {
  return(expected_tax - actual_tax_paid)
}

#' Track CIT payments for a company
#' @param company_id Numeric. The unique company identifier.
#' @param period Character. Either 'annual' or 'quarterly'.
#' @return Data frame. Payment tracking details.
#' @examples
#' track_cit_payments(101)
track_cit_payments <- function(company_id, period = "annual") {
  return(data.frame(company_id = company_id, period = period, status = "Pending"))
}

#' Compute penalty for late CIT payments
#' @param days_late Numeric. Number of days past due date.
#' @return Numeric. The penalty amount.
#' @examples
#' penalty_for_late_cit_payment(30)  # Returns penalty
penalty_for_late_cit_payment <- function(days_late) {
  return(days_late * 5000)  # NGN 5,000 per day
}

