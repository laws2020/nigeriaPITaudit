# Compute Withholding Tax (WHT)
compute_wht <- function(amount, rate = 5) {
  if (!is.numeric(amount) || amount < 0) stop("Amount must be a positive numeric value.")
  return(round(amount * (rate / 100), 2))
}

# Lookup WHT rate based on transaction type
wht_rate_lookup <- function(transaction_type) {
  rates <- list(
    "contract" = 5,
    "professional_services" = 10,
    "dividends" = 10,
    "interest" = 10
  )
  return(rates[[transaction_type]] %||% stop("Unknown transaction type."))
}

# Apply WHT to an invoice
apply_wht_to_invoice <- function(invoice_amount, wht_rate) {
  if (!is.numeric(invoice_amount) || invoice_amount < 0) stop("Invalid invoice amount.")
  return(round(invoice_amount - compute_wht(invoice_amount, wht_rate), 2))
}

# Check if a transaction exceeds the WHT threshold
wht_threshold_check <- function(transaction_amount, threshold = 1000000) {
  return(transaction_amount >= threshold)
}

# List WHT-exempt services
wht_exempt_services <- function() {
  return(c("salaries", "reimbursements", "loan repayments"))
}

# Validate WHT deductions in a dataset
validate_wht_deductions <- function(payment_data) {
  return(payment_data[payment_data$wht_applied > compute_wht(payment_data$amount, payment_data$rate), ])
}

# Generate WHT summary report
wht_summary <- function(data, period = "monthly") {
  summary <- aggregate(data$wht_applied, by = list(data$company_id), FUN = sum)
  colnames(summary) <- c("Company ID", "Total WHT")
  return(summary)
}

# Check WHT filing deadline
wht_filing_deadline_check <- function(date) {
  deadline <- as.Date(c("2025-01-21", "2025-04-21", "2025-07-21", "2025-10-21"))
  return(date %in% deadline)
}

# Generate WHT report
generate_wht_report <- function(data, period = "monthly") {
  return(data[data$period == period, ])
}

# Reconcile expected and actual WHT payments
reconcile_wht <- function(expected_wht, actual_wht) {
  return(round(expected_wht - actual_wht, 2))
}

# Track WHT payments by company
track_wht_payments <- function(company_id, period = "quarterly") {
  return(paste("Tracking WHT payments for Company", company_id, "for", period, "period."))
}

# Compute penalty for late WHT payment
penalty_for_late_wht_payment <- function(days_late) {
  penalty_rate <- 0.05
  return(round(days_late * penalty_rate, 2))
}

# Examples
# compute_wht(100000, 5)
# wht_rate_lookup("contract")
# apply_wht_to_invoice(200000, 5)
# wht_threshold_check(1500000)
# wht_exempt_services()
# validate_wht_deductions(payment_data)
# wht_summary(wht_data, "monthly")
# wht_filing_deadline_check(as.Date("2025-01-21"))
# generate_wht_report(wht_data, "monthly")
# reconcile_wht(50000, 48000)
# track_wht_payments(12345, "quarterly")
# penalty_for_late_wht_payment(30)

