# nigeriaPITaudit

A Comprehensive Toolkit for Auditing Personal Income Tax in Nigeria

## Overview
nigeriaPITaudit is a powerful R toolkit designed to assist tax auditors, accountants, and government agencies in auditing personal income tax (PIT) compliance in Nigeria. The package simplifies tax assessments, identifies discrepancies, and ensures compliance with Nigerian tax laws.

## Features
* Automated tax audit calculations based on Nigerian tax laws
* Data validation for tax records
* Analysis of taxable income, deductions, and exemptions
* Reporting tools for audit summaries

## Installation
### Install from GitHub
r
## Install devtools if not already installed
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

## Install nigeriaPITaudit from GitHub
devtools::install_github("laws2020/nigeriaPITaudit/nigeriaPITaudit")


*Usage*
*Load the package and use its functions for tax audits*

## Load the nigeriaPITaudit package
library(nigeriaPITaudit)

## Load sample tax data (replace with your own file path)
taxdata <- fetch_tax_data("path/to/your/tax/data.xlsx")

## Extract relevant data frame
df <- taxdata$`LIA TARABA 2017`

## Convert necessary columns to correct types
df$`Name` <- as.character(df$`Name`)
df$`Basic Salary` <- as.numeric(df$`Basic Salary`)
df$`Teaching Allowance` <- as.numeric(df$`Teaching Allowance`)

## Compute salary components (using key functions from nigeriaPITaudit)
gross <- gross_salary(df$`Basic Salary`, df$`Teaching Allowance`)
pension <- pension_deduction(gross)
taxableIncome <- taxable_income(gross, pension)
employeeLiability <- employee_tax_liability(taxableIncome, "monthly")

## Create a summary data frame
dftaxreport <- data.frame(
  Name = df$`Name`,
  gross,
  pension,
  taxableIncome,
  employeeLiability
)

## View summary report
View(dftaxreport)

## Save report to Excel file 
library(writexl)
write_xlsx(dftaxreport, "path/to/your/report.xlsx")


*Contributing*
I welcome contributions! If you would like to improve the package:

- Fork the repository
- Create a new branch (feature-new-functionality)
- Commit your changes
- Submit a pull request

*License*
This package is licensed under the MIT License – see the LICENSE file for details.

*Contact*
For support or inquiries, please contact laws.garba@gmail.com or open an issue on GitHub.

```
