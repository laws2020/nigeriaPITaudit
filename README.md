
## **nigeriaPITaudit**

<figure>
<img
src="https://img.shields.io/github/license/laws2020/nigeriaPITaudit"
alt="GitHub" />
<figcaption aria-hidden="true">GitHub</figcaption>
</figure>

#### A Comprehensive Toolkit for Auditing Personal Income Tax in Nigeria

### **Overview**

`nigeriaPITaudit` is an R package designed to streamline the auditing of
personal income tax (PIT) in Nigeria. It assists tax auditors,
accountants, and government agencies in evaluating tax compliance,
identifying discrepancies, and ensuring adherence to Nigerian tax laws.

### **Features**

✔ Automated tax audit calculations based on Nigerian tax regulations  
✔ Data validation for tax records  
✔ Analysis of taxable income, deductions, and exemptions  
✔ Reporting tools for generating audit summaries

------------------------------------------------------------------------

### **Installation**

#### **Prerequisites**

Ensure that R (version 4.0 or higher) and RStudio are installed.

#### **Step 1: Install `devtools` (if not already installed)**

``` r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
```

### Install nigeriaPITaudit from GitHub

``` r
# devtools::install_github("laws2020/nigeriaPITaudit/nigeriaPITaudit")
```

## The Birth of `nigeriaPITaudit`

### Chapter 1: A Journey Through Time

Five years ago, I worked in the auditing department with the **Internal
Revenue Service (IRS)**. My main responsibility was conducting **payroll
audits**—a task that required patience, accuracy, and mastery of
financial tools.

After two years, my boss decided that my skills were needed elsewhere
and I was transferred to a different department to handle what was
considered **a more critical role** at the time.

But something interesting happened. My former colleagues in the auditing
department **kept coming to me** for help with payroll audits. Time and
again, I reminded them, **“I have a new role now, and I can’t handle two
responsibilities at once.”** I encouraged them to **learn Excel** and
take ownership of their work.

However, despite all my efforts, I still found myself handling **two
roles**—whether I liked it or not. The annoying part is that even after
I left the IRS, my former colleagues continued reaching out for help.

Their unwillingness to learn **pushed me to create something greater,
but more easier to excel**. I wanted to empower them and others like
them to perform payroll audits with ease. And so, the
**`nigeriaPITaudit`** package was born—a tool designed to simplify
payroll auditing in R!

### Chapter 2: Unlocking Payroll Secrets with `nigeriaPITaudit`

To embark on this journey, first, we must summon the power of
nigeriaPITaudit package:

``` r
library(nigeriaPITaudit)
library(knitr)
```

### Unveiling the Payroll Data

We retrieve the payroll data hidden in the nigeriaPITaudit archives:

``` r
data("fmc2017")
```

Before proceeding, let’s inspect the structure of the dataset:

``` r
str(fmc2017)
```

    ## tibble [1,148 × 14] (S3: tbl_df/tbl/data.frame)
    ##  $ S/N               : num [1:1148] 1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Name              : chr [1:1148] "DR. INUSA WIZA" "DR. WANONYI I. KWALA" "DR. EKANEM E.D" "Dr. Arinze Egboga" ...
    ##  $ Staff_No          : chr [1:1148] "SS\\537" "SS\\237" "SS\\192" "SS\\943" ...
    ##  $ ConM/H            : chr [1:1148] "MD" "15\\9" "15\\9" "15\\9" ...
    ##  $ Basic_Salary      : num [1:1148] 120367 428250 428250 428250 428250 ...
    ##  $ Teaching_Allowance: num [1:1148] 37628 37628 37628 37628 37628 ...
    ##  $ Salary_Arrears    : num [1:1148] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ other_allowances  : num [1:1148] 891528 0 0 0 0 ...
    ##  $ Overtime          : num [1:1148] 0 0 0 0 0 0 0 0 0 0 ...
    ##  $ Shifting          : num [1:1148] NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Speacilist        : num [1:1148] NA 169327 169327 169327 169327 ...
    ##  $ Hazard_Allowance  : num [1:1148] 5000 5000 5000 5000 5000 5000 5000 5000 5000 5000 ...
    ##  $ Call_Allowance    : num [1:1148] 162680 162680 162680 162680 162680 ...
    ##  $ Netpay            : num [1:1148] 1217203 802885 802885 802885 802885 ...

We now store it in a **data frame** for easy manipulation:

``` r
df <- fmc2017
```

For the purpose of this examples we will like to limit the number of
employee to audit, just 8 instead of the entire data we have here.

``` r
df <- fmc2017[c(1:8), ]
```

### Calculating Salary Components

To compute **gross salaries**, we use:

``` r
gross <- gross_salary(df$Basic_Salary, df$Teaching_Allowance, df$Salary_Arrears,
                      df$other_allowances, df$Overtime, df$Shifting, df$Speacilist,
                      df$Hazard_Allowance)
```

### Deductions: Shielding Employees from Tax Burden

We then calculate key deductions:

``` r
pension <- pension_deduction(gross)
nhf <- nhf_deduction(gross)
nhis <- nhis_deduction(gross)
```

### Computing Net Income and Tax Liabilities

We determine the **gross income**:

``` r
grossIncome <- gross_income(gross, pension, nhis, nhf)
```

Applying **consolidated relief**:

``` r
consolidatedRelief <- consolidated_relief(grossIncome, "monthly")
```

Total relief calculation:

``` r
totalRelief <- total_relief(pension, nhis, nhf, consolidatedRelief)
```

Finally, we compute **taxable income** and **employee tax liability**:

``` r
taxableIncome <- taxable_income(gross, totalRelief)
employeeLiability <- employee_tax_liability(taxableIncome, "monthly")
```

### Chapter 3: The Final Report

With all calculations complete, we compile a **comprehensive payroll tax
report**:

``` r
dftaxreport <- data.frame(
  Name = df$Name,  # Explicitly reference df$Name
  gross, pension, nhis, nhf, grossIncome, consolidatedRelief, 
  totalRelief, taxableIncome, employeeLiability
  
)
```

``` r
columns_to_sum <- c("gross", "pension", "nhis", "nhf", "grossIncome", "consolidatedRelief", "totalRelief", "taxableIncome", "employeeLiability")
```

``` r
result <- sum_cols(dftaxreport, columns_to_sum)
```

To summarize records:

``` r
kable(caption = "Summary of Personal Income Tax Audit", result)
```

|       | Name                  |     gross |   pension |      nhis |        nhf | grossIncome | consolidatedRelief | totalRelief | taxableIncome | employeeLiability |
|:------|:----------------------|----------:|----------:|----------:|-----------:|------------:|-------------------:|------------:|--------------:|------------------:|
| 1     | DR. INUSA WIZA        | 1054522.7 |  84361.82 |  52726.14 |  26363.068 |    891071.7 |          194881.01 |    358332.0 |      696190.7 |         149752.40 |
| 2     | DR. WANONYI I. KWALA  |  640205.1 |  51216.41 |  32010.25 |  16005.127 |    540973.3 |          124861.33 |    224093.1 |      416112.0 |          82533.50 |
| 3     | DR. EKANEM E.D        |  640205.1 |  51216.41 |  32010.25 |  16005.127 |    540973.3 |          124861.33 |    224093.1 |      416112.0 |          82533.50 |
| 4     | Dr. Arinze Egboga     |  640205.1 |  51216.41 |  32010.25 |  16005.127 |    540973.3 |          124861.33 |    224093.1 |      416112.0 |          82533.50 |
| 5     | DR. MA’AJI THEOPHILUS |  640205.1 |  51216.41 |  32010.25 |  16005.127 |    540973.3 |          124861.33 |    224093.1 |      416112.0 |          82533.50 |
| 6     | DR. STEPHEN PAUL AJEH |  532105.8 |  42568.47 |  26605.29 |  13302.646 |    449629.4 |          106592.55 |    189069.0 |      343036.9 |          64995.48 |
| 7     | DR. ADOR JOHN UNIGA   |  312468.2 |  24997.45 |  15623.41 |   7811.704 |    264035.6 |           69473.79 |    117906.4 |      194561.8 |          31524.62 |
| 8     | Dr. Aisha Mohammed    |  312468.2 |  24997.45 |  15623.41 |   7811.704 |    264035.6 |           69473.79 |    117906.4 |      194561.8 |          31524.62 |
| Total | NA                    | 4772385.3 | 381790.82 | 238619.26 | 119309.632 |   4032665.5 |          939866.46 |   1679586.2 |     3092799.1 |         607931.12 |

Summary of Personal Income Tax Audit

### Chapter 4: Preserving the Knowledge

To ensure that our findings remain accessible, we store the results in
an **Excel file**:

``` r
library(writexl)
write_xlsx(summary_result, "C:/Users/Lawrence Daniel/Downloads/practiceAudit.xlsx")
```

And so, my journey from **IRS auditor** to **R package developer** comes
full circle. With `nigeriaPITaudit`, anyone can now conduct payroll
audits effortlessly.

### cheat sheet

*consolidated_relief(gross_income, period = “yearly”)*

*employee_tax_liability(taxable_income, period = “yearly”)*

*fetch_tax_data(infile)*

*gross_income(gross_salary, pension, nhis, nhf)*

*gross_salary(…)*

*nhf_deduction(gross_salary, rate = 0.025)*

*nhis_deduction(gross_salary, rate = 0.05)*

*outstanding_liability(actual_employeeLiability, payment_made)*

*penalty_and_interest(unpaid_tax, due_date, payment_date, employer_type
= “corporate”)*

*pension_deduction(gross_salary, rate = 0.08)*

*rent_relief(rent_paid)*

*sum_cols(df, cols_to_sum)*

*taxable_income(gross_salary, total_relief)*

*tax_exemption(gross_salary, rate)*

*total_relief(cra_value, pension, nhf, nhis)*

This package is not just a tool—it’s my way of ensuring that **learning
and self-sufficiency triumph over dependency**.

**Now, go forth and audit with confidence!**

### Contributing

Contributions are welcome!

### How to Contribute

Fork the repository Create a new branch (feature-new-functionality)
Commit your changes Submit a Pull Request

For major changes, please open an issue first to discuss your proposed
modifications.

### License

This package is licensed under the MIT License. See the LICENSE file for
more details.

### Contact

For support or inquiries: Email: <laws.garba@gmail.com> GitHub Issues:
Open an Issue
