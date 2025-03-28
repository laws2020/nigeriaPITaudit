
# **nigeriaPITaudit**

<figure>
<img
src="https://img.shields.io/github/license/laws2020/nigeriaPITaudit"
alt="GitHub" />
<figcaption aria-hidden="true">GitHub</figcaption>
</figure>

### A Comprehensive Toolkit for Auditing Personal Income Tax in Nigeria

## **Overview**

`nigeriaPITaudit` is an R package designed to streamline the auditing of
personal income tax (PIT) in Nigeria. It assists tax auditors,
accountants, and government agencies in evaluating tax compliance,
identifying discrepancies, and ensuring adherence to Nigerian tax laws.

## **Features**

✔ Automated tax audit calculations based on Nigerian tax regulations  
✔ Data validation for tax records  
✔ Analysis of taxable income, deductions, and exemptions  
✔ Reporting tools for generating audit summaries

------------------------------------------------------------------------

## **Installation**

### **Prerequisites**

Ensure that R (version 4.0 or higher) and RStudio are installed.

### **Step 1: Install `devtools` (if not already installed)**

``` r
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}
```

### Install nigeriaPITaudit from GitHub

``` r
devtools::install_github("laws2020/nigeriaPITaudit/nigeriaPITaudit")
```

    ## Using GitHub PAT from the git credential store.

    ## Downloading GitHub repo laws2020/nigeriaPITaudit@HEAD

    ## 
    ## ── R CMD build ─────────────────────────────────────────────────────────────────
    ##          checking for file 'C:\Users\Lawrence Daniel\AppData\Local\Temp\RtmpuWsV2n\remotes4c041ce71bca\laws2020-nigeriaPITaudit-5c7b75a\nigeriaPITaudit/DESCRIPTION' ...  ✔  checking for file 'C:\Users\Lawrence Daniel\AppData\Local\Temp\RtmpuWsV2n\remotes4c041ce71bca\laws2020-nigeriaPITaudit-5c7b75a\nigeriaPITaudit/DESCRIPTION' (548ms)
    ##       ─  preparing 'nigeriaPITaudit': (943ms)
    ##    checking DESCRIPTION meta-information ...     checking DESCRIPTION meta-information ...   ✔  checking DESCRIPTION meta-information
    ##       ─  checking for LF line-endings in source and make files and shell scripts (636ms)
    ##       ─  checking for empty or unneeded directories
    ##      NB: this package now depends on R (>=        NB: this package now depends on R (>= 3.5.0)
    ##        WARNING: Added dependency on R >= 3.5.0 because serialized objects in
    ##      serialize/load version 3 cannot be read in older versions of R.
    ##      File(s) containing such objects:
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-1_09ac111be2b3d707242711fe829d37c4.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-1_09ac111be2b3d707242711fe829d37c4.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-2_8c47e6e24fc2e9ef060de1cf8f9ee0b0.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-2_8c47e6e24fc2e9ef060de1cf8f9ee0b0.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-3_e7e02a2a88c55fbff20366b7663538cb.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-3_e7e02a2a88c55fbff20366b7663538cb.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-4_2f102f8e65c8b4b74a6529102395da90.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-4_2f102f8e65c8b4b74a6529102395da90.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-5_3124e9b4a9021e918065c77617958744.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-5_3124e9b4a9021e918065c77617958744.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-6_895a5eaffbc61cb7cbd0872759079ee8.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-6_895a5eaffbc61cb7cbd0872759079ee8.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-7_4df1d75fb0ff0f52a68330fcede51e8a.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-7_4df1d75fb0ff0f52a68330fcede51e8a.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-8_9e497c06420f23170671181989158353.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-8_9e497c06420f23170671181989158353.rdx'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-9_aff058a39e64d72c371b05e0d83c27cc.RData'
    ##        'nigeriaPITaudit/vignettes/cache/unnamed-chunk-9_aff058a39e64d72c371b05e0d83c27cc.rdx'
    ##   ─  building 'nigeriaPITaudit_0.0.1.tar.gz'
    ##      
    ## 

    ## Installing package into 'C:/Users/Lawrence Daniel/AppData/Local/Temp/RtmpIhCOJg/temp_libpath31b46d1c10fe'
    ## (as 'lib' is unspecified)

# The Birth of `nigeriaPITaudit`

## Chapter 1: A Journey Through Time

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

## Chapter 2: Unlocking Payroll Secrets with `nigeriaPITaudit`

To embark on this journey, first, we must summon the power of
nigeriaPITaudit package:

``` r
library(nigeriaPITaudit)
library(knitr)
```

    ## Warning: package 'knitr' was built under R version 4.4.3

### Unveiling the Payroll Data

We retrieve the payroll data hidden in the nigeriaPITaudit archives:

``` r
data("fmc2017")
```

Before proceeding, let’s inspect the structure of the dataset:

``` r
str(fmc2017)
```

    ## Classes 'tbl_df', 'tbl' and 'data.frame':    1148 obs. of  14 variables:
    ##  $ S/N               : num  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ Name              : chr  "DR. INUSA WIZA" "DR. WANONYI I. KWALA" "DR. EKANEM E.D" "Dr. Arinze Egboga" ...
    ##  $ Staff_No          : chr  "SS\\537" "SS\\237" "SS\\192" "SS\\943" ...
    ##  $ ConM/H            : chr  "MD" "15\\9" "15\\9" "15\\9" ...
    ##  $ Basic_Salary      : num  120367 428250 428250 428250 428250 ...
    ##  $ Teaching_Allowance: num  37628 37628 37628 37628 37628 ...
    ##  $ Salary_Arrears    : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ other_allowances  : num  891528 0 0 0 0 ...
    ##  $ Overtime          : num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ Shifting          : num  NA NA NA NA NA NA NA NA NA NA ...
    ##  $ Speacilist        : num  NA 169327 169327 169327 169327 ...
    ##  $ Hazard_Allowance  : num  5000 5000 5000 5000 5000 5000 5000 5000 5000 5000 ...
    ##  $ Call_Allowance    : num  162680 162680 162680 162680 162680 ...
    ##  $ Netpay            : num  1217203 802885 802885 802885 802885 ...

We now store it in a **data frame** for easy manipulation:

``` r
df <- fmc2017
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

## Chapter 3: The Final Report

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

To summarize only the **first five and last five** records:

``` r
library(knitr)

summary_result <- rbind(head(result, 5), tail(result, 5))

kable(summary_result, caption = "Summary of Personal Income Tax Audit")
```

|       | Name                  |         gross |     pension |        nhis |          nhf | grossIncome | consolidatedRelief | totalRelief | taxableIncome | employeeLiability |
|:------|:----------------------|--------------:|------------:|------------:|-------------:|------------:|-------------------:|------------:|--------------:|------------------:|
| 1     | DR. INUSA WIZA        |    1054522.73 |   84361.818 |   52726.137 |   26363.0683 |   891071.71 |          194881.01 |   358332.03 |    696190.697 |         149752.40 |
| 2     | DR. WANONYI I. KWALA  |     640205.09 |   51216.407 |   32010.254 |   16005.1272 |   540973.30 |          124861.33 |   224093.12 |    416111.971 |          82533.50 |
| 3     | DR. EKANEM E.D        |     640205.09 |   51216.407 |   32010.254 |   16005.1272 |   540973.30 |          124861.33 |   224093.12 |    416111.971 |          82533.50 |
| 4     | Dr. Arinze Egboga     |     640205.09 |   51216.407 |   32010.254 |   16005.1272 |   540973.30 |          124861.33 |   224093.12 |    416111.971 |          82533.50 |
| 5     | DR. MA’AJI THEOPHILUS |     640205.09 |   51216.407 |   32010.254 |   16005.1272 |   540973.30 |          124861.33 |   224093.12 |    416111.971 |          82533.50 |
| 1145  | Timothy Ilu           |      29563.66 |    2365.093 |    1478.183 |     739.0915 |    24981.29 |           21662.93 |    26245.30 |      3318.363 |            232.29 |
| 1146  | Sanda Abubakar W.     |      28367.42 |    2269.394 |    1418.371 |     709.1855 |    23970.47 |           21460.76 |    25857.71 |      2509.710 |            175.68 |
| 1147  | Ismaila Yakubu        |      27618.58 |    2209.486 |    1380.929 |     690.4645 |    23337.70 |           21334.21 |    25615.09 |      2003.490 |            140.24 |
| 1148  | Usman Abba            |      27618.58 |    2209.486 |    1380.929 |     690.4645 |    23337.70 |           21334.21 |    25615.09 |      2003.490 |            140.24 |
| Total | NA                    | 114557099\.25 | 9164567.940 | 5727854.963 | 2863927.4813 | 96800748.87 |        38493482.55 | 56249832.93 |  58307266.316 |        7169047.02 |

Summary of Personal Income Tax Audit

## Chapter 4: Preserving the Knowledge

To ensure that our findings remain accessible, we store the results in
an **Excel file**:

``` r
library(writexl)
```

    ## Warning: package 'writexl' was built under R version 4.4.3

``` r
write_xlsx(summary_result, "C:/Users/Lawrence Daniel/Downloads/practiceAudit.xlsx")
```

And so, my journey from **IRS auditor** to **R package developer** comes
full circle. With `nigeriaPITaudit`, anyone can now conduct payroll
audits effortlessly.

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
