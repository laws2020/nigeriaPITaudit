#' Compute VAT Amount
#'
#' This function calculates the VAT payable on a given amount.
#'
#' @param amount Numeric. The amount on which VAT is applied.
#' @param rate Numeric. The VAT rate (default is 7.5%).
#'
#' @return Numeric. The computed VAT amount.
#' @export
compute_vat <- function(amount, rate = 7.5) {
  if (!is.numeric(amount) || amount < 0) {
    stop("Amount must be a positive numeric value.")
  }
  return(round((rate / 100) * amount, 2))
}

#' Compute Net VAT Payable
#'
#' This function calculates the net VAT payable based on output and input VAT.
#'
#' @param output_vat Numeric. VAT collected on sales.
#' @param input_vat Numeric. VAT paid on purchases.
#'
#' @return Numeric. The net VAT payable.
#' @export
net_vat_payable <- function(output_vat, input_vat) {
  if (!is.numeric(output_vat) || !is.numeric(input_vat) || output_vat < 0 || input_vat < 0) {
    stop("Both output and input VAT must be positive numeric values.")
  }
  return(round(output_vat - input_vat, 2))
}

#' VAT Exempt Items
#'
#' This function returns a list of VAT-exempt items in Nigeria.
#'
#' @return Character vector. List of VAT-exempt items.
#' @export
vat_exempt_items <- function() {
  exempt_items <- c("Basic food items", "Medical services", "Pharmaceutical products", 
                    "Educational materials", "Agricultural products", "Rent on residential property")
  return(exempt_items)
}

#' VAT Threshold Check
#'
#' This function checks if a business meets the VAT registration threshold.
#'
#' @param revenue Numeric. The company's annual revenue.
#' @param threshold Numeric. The VAT registration threshold (default is ₦25 million).
#'
#' @return Logical. TRUE if revenue meets or exceeds the threshold, FALSE otherwise.
#' @export
vat_threshold_check <- function(revenue, threshold = 25e6) {
  if (!is.numeric(revenue) || revenue < 0) {
    stop("Revenue must be a positive numeric value.")
  }
  return(revenue >= threshold)
}

#' Generate VAT Summary
#'
#' This function provides a summary of VAT transactions from a dataset.
#'
#' @param data Data frame. A dataset containing VAT-related transactions.
#'
#' @return Data frame. Summary of VAT transactions.
#' @export
vat_summary <- function(data) {
  if (!is.data.frame(data) || !all(c("amount", "vat") %in% names(data))) {
    stop("Data must be a data frame containing 'amount' and 'vat' columns.")
  }
  summary <- data.frame(
    Total_Transactions = nrow(data),
    Total_Amount = sum(data$amount, na.rm = TRUE),
    Total_VAT = sum(data$vat, na.rm = TRUE)
  )
  return(summary)
}

#' VAT Filing Deadline
#'
#' This function calculates the VAT filing deadline for a given month.
#'
#' @param date Date. A reference date within the filing period.
#'
#' @return Date. The deadline for VAT filing.
#' @export
vat_filing_deadline <- function(date) {
  if (!inherits(date, "Date")) {
    stop("Input must be a Date object.")
  }
  return(as.Date(format(date, "%Y-%m-01")) + 20)
}

#' Generate VAT Report
#'
#' This function generates a VAT report for a specified period.
#'
#' @param data Data frame. A dataset containing VAT transactions.
#' @param period Character. The reporting period, either "monthly" or "yearly".
#'
#' @return Data frame. A VAT report summary.
#' @export
generate_vat_report <- function(data, period = "monthly") {
  if (!is.data.frame(data) || !all(c("date", "amount", "vat") %in% names(data))) {
    stop("Data must be a data frame containing 'date', 'amount', and 'vat' columns.")
  }
  
  data$date <- as.Date(data$date)
  
  if (period == "monthly") {
    report <- aggregate(cbind(amount, vat) ~ format(date, "%Y-%m"), data, sum)
  } else if (period == "yearly") {
    report <- aggregate(cbind(amount, vat) ~ format(date, "%Y"), data, sum)
  } else {
    stop("Invalid period. Choose either 'monthly' or 'yearly'.")
  }
  
  return(report)
}

#' Reconcile VAT Payments
#'
#' This function reconciles expected and actual VAT payments.
#'
#' @param expected_vat Numeric. The expected VAT liability.
#' @param actual_vat Numeric. The actual VAT paid.
#'
#' @return Numeric. The discrepancy between expected and actual VAT payments.
#' @export
reconcile_vat_payments <- function(expected_vat, actual_vat) {
  if (!is.numeric(expected_vat) || !is.numeric(actual_vat) || expected_vat < 0 || actual_vat < 0) {
    stop("Both expected and actual VAT must be positive numeric values.")
  }
  return(round(expected_vat - actual_vat, 2))
}

#' Track VAT Payments
#'
#' This function tracks VAT payments for a given company over a specified period.
#'
#' @param company_id Character. The company's unique identifier.
#' @param period Character. The tracking period, either "monthly" or "yearly".
#'
#' @return Data frame. A summary of VAT payments.
#' @export
track_vat_payments <- function(company_id, period = "monthly") {
  # Simulating VAT payments data (replace with actual database query in production)
  data <- data.frame(
    company_id = rep(company_id, 12),
    date = seq(as.Date("2024-01-01"), by = "month", length.out = 12),
    vat_paid = runif(12, 50000, 200000)  # Random VAT payments
  )
  
  if (period == "monthly") {
    return(data)
  } else if (period == "yearly") {
    return(aggregate(vat_paid ~ format(date, "%Y"), data, sum))
  } else {
    stop("Invalid period. Choose either 'monthly' or 'yearly'.")
  }
}

#' Calculate Penalty for Late VAT Payment
#'
#' This function calculates penalties for late VAT payments.
#'
#' @param days_late Integer. The number of days past the due date.
#'
#' @return Numeric. The penalty amount based on the Finance Act guidelines.
#' @export
penalty_for_late_vat_payment <- function(days_late) {
  if (!is.numeric(days_late) || days_late < 0) {
    stop("Days late must be a positive integer.")
  }
  penalty_rate <- 0.05  # 5% penalty
  return(round(days_late * penalty_rate, 2))
}
