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

    if (!requireNamespace("devtools", quietly = TRUE)) {
      install.packages("devtools")
    }

### Install nigeriaPITaudit from GitHub

    # devtools::install_github("laws2020/nigeriaPITaudit/nigeriaPITaudit")

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

### Chapter 2: Unveiling Payroll Secrets with `nigeriaPITaudit`

To embark on this journey, first, we must summon the power of
nigeriaPITaudit package:

    library(nigeriaPITaudit)
    library(knitr)

### Here comes the Payroll Data

We retrieve the payroll data hidden in the nigeriaPITaudit archives:

    data("fmc2017")

Before proceeding, let’s inspect the structure of the dataset:

    str(fmc2017)

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

    df <- fmc2017

For the purpose of this examples we will like to limit the number of
employee to audit, just 8 instead of the entire data we have here.

    df <- fmc2017[c(1:8), ]

### Calculating Salary Components

To compute **gross salaries**, we use:

    gross <- gross_salary(df$Basic_Salary, df$Teaching_Allowance, df$Salary_Arrears,
                          df$other_allowances, df$Overtime, df$Shifting, df$Speacilist,
                          df$Hazard_Allowance)

### Deductions: Shielding Employees from Tax Burden

We then calculate key deductions:

    pension <- pension_deduction(gross)
    nhf <- nhf_deduction(gross)
    nhis <- nhis_deduction(gross)

### Computing Net Income and Tax Liabilities

We determine the **gross income**:

    grossIncome <- gross_income(gross, pension, nhis, nhf)

Applying **consolidated relief**:

    consolidatedRelief <- consolidated_relief(grossIncome, "monthly")

Total relief calculation:

    totalRelief <- total_relief(pension, nhis, nhf, consolidatedRelief)

Finally, we compute **taxable income** and **employee tax liability**:

    taxableIncome <- taxable_income(gross, totalRelief)
    employeeLiability <- employee_tax_liability(taxableIncome, "monthly")

### Chapter 3: The Final Report

With all calculations complete, we compile a **comprehensive payroll tax
report**:

    dftaxreport <- data.frame(
      Name = df$Name,  # Explicitly reference df$Name
      gross, pension, nhis, nhf, grossIncome, consolidatedRelief, 
      totalRelief, taxableIncome, employeeLiability
      
    )

    columns_to_sum <- c("gross", "pension", "nhis", "nhf", "grossIncome", "consolidatedRelief", "totalRelief", "taxableIncome", "employeeLiability")

    result <- sum_cols(dftaxreport, columns_to_sum)

To summarize records:

    kable(result, caption = "Summary of Personal Income Tax Audit")

<table>
<caption>Summary of Personal Income Tax Audit</caption>
<colgroup>
<col style="width: 4%" />
<col style="width: 15%" />
<col style="width: 6%" />
<col style="width: 6%" />
<col style="width: 6%" />
<col style="width: 7%" />
<col style="width: 8%" />
<col style="width: 13%" />
<col style="width: 8%" />
<col style="width: 9%" />
<col style="width: 12%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">Name</th>
<th style="text-align: right;">gross</th>
<th style="text-align: right;">pension</th>
<th style="text-align: right;">nhis</th>
<th style="text-align: right;">nhf</th>
<th style="text-align: right;">grossIncome</th>
<th style="text-align: right;">consolidatedRelief</th>
<th style="text-align: right;">totalRelief</th>
<th style="text-align: right;">taxableIncome</th>
<th style="text-align: right;">employeeLiability</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1</td>
<td style="text-align: left;">DR. INUSA WIZA</td>
<td style="text-align: right;">1054522.7</td>
<td style="text-align: right;">84361.82</td>
<td style="text-align: right;">52726.14</td>
<td style="text-align: right;">26363.068</td>
<td style="text-align: right;">891071.7</td>
<td style="text-align: right;">194881.01</td>
<td style="text-align: right;">358332.0</td>
<td style="text-align: right;">696190.7</td>
<td style="text-align: right;">149752.40</td>
</tr>
<tr class="even">
<td style="text-align: left;">2</td>
<td style="text-align: left;">DR. WANONYI I. KWALA</td>
<td style="text-align: right;">640205.1</td>
<td style="text-align: right;">51216.41</td>
<td style="text-align: right;">32010.25</td>
<td style="text-align: right;">16005.127</td>
<td style="text-align: right;">540973.3</td>
<td style="text-align: right;">124861.33</td>
<td style="text-align: right;">224093.1</td>
<td style="text-align: right;">416112.0</td>
<td style="text-align: right;">82533.50</td>
</tr>
<tr class="odd">
<td style="text-align: left;">3</td>
<td style="text-align: left;">DR. EKANEM E.D</td>
<td style="text-align: right;">640205.1</td>
<td style="text-align: right;">51216.41</td>
<td style="text-align: right;">32010.25</td>
<td style="text-align: right;">16005.127</td>
<td style="text-align: right;">540973.3</td>
<td style="text-align: right;">124861.33</td>
<td style="text-align: right;">224093.1</td>
<td style="text-align: right;">416112.0</td>
<td style="text-align: right;">82533.50</td>
</tr>
<tr class="even">
<td style="text-align: left;">4</td>
<td style="text-align: left;">Dr. Arinze Egboga</td>
<td style="text-align: right;">640205.1</td>
<td style="text-align: right;">51216.41</td>
<td style="text-align: right;">32010.25</td>
<td style="text-align: right;">16005.127</td>
<td style="text-align: right;">540973.3</td>
<td style="text-align: right;">124861.33</td>
<td style="text-align: right;">224093.1</td>
<td style="text-align: right;">416112.0</td>
<td style="text-align: right;">82533.50</td>
</tr>
<tr class="odd">
<td style="text-align: left;">5</td>
<td style="text-align: left;">DR. MA’AJI THEOPHILUS</td>
<td style="text-align: right;">640205.1</td>
<td style="text-align: right;">51216.41</td>
<td style="text-align: right;">32010.25</td>
<td style="text-align: right;">16005.127</td>
<td style="text-align: right;">540973.3</td>
<td style="text-align: right;">124861.33</td>
<td style="text-align: right;">224093.1</td>
<td style="text-align: right;">416112.0</td>
<td style="text-align: right;">82533.50</td>
</tr>
<tr class="even">
<td style="text-align: left;">6</td>
<td style="text-align: left;">DR. STEPHEN PAUL AJEH</td>
<td style="text-align: right;">532105.8</td>
<td style="text-align: right;">42568.47</td>
<td style="text-align: right;">26605.29</td>
<td style="text-align: right;">13302.646</td>
<td style="text-align: right;">449629.4</td>
<td style="text-align: right;">106592.55</td>
<td style="text-align: right;">189069.0</td>
<td style="text-align: right;">343036.9</td>
<td style="text-align: right;">64995.48</td>
</tr>
<tr class="odd">
<td style="text-align: left;">7</td>
<td style="text-align: left;">DR. ADOR JOHN UNIGA</td>
<td style="text-align: right;">312468.2</td>
<td style="text-align: right;">24997.45</td>
<td style="text-align: right;">15623.41</td>
<td style="text-align: right;">7811.704</td>
<td style="text-align: right;">264035.6</td>
<td style="text-align: right;">69473.79</td>
<td style="text-align: right;">117906.4</td>
<td style="text-align: right;">194561.8</td>
<td style="text-align: right;">31524.62</td>
</tr>
<tr class="even">
<td style="text-align: left;">8</td>
<td style="text-align: left;">Dr. Aisha Mohammed</td>
<td style="text-align: right;">312468.2</td>
<td style="text-align: right;">24997.45</td>
<td style="text-align: right;">15623.41</td>
<td style="text-align: right;">7811.704</td>
<td style="text-align: right;">264035.6</td>
<td style="text-align: right;">69473.79</td>
<td style="text-align: right;">117906.4</td>
<td style="text-align: right;">194561.8</td>
<td style="text-align: right;">31524.62</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Total</td>
<td style="text-align: left;">NA</td>
<td style="text-align: right;">4772385.3</td>
<td style="text-align: right;">381790.82</td>
<td style="text-align: right;">238619.26</td>
<td style="text-align: right;">119309.632</td>
<td style="text-align: right;">4032665.5</td>
<td style="text-align: right;">939866.46</td>
<td style="text-align: right;">1679586.2</td>
<td style="text-align: right;">3092799.1</td>
<td style="text-align: right;">607931.12</td>
</tr>
</tbody>
</table>

Summary of Personal Income Tax Audit

And so, my journey from **IRS auditor** to **R package developer** comes
full circle. With `nigeriaPITaudit`, anyone can now conduct payroll
audits effortlessly.

### cheat sheet

*consolidated\_relief(gross\_income, period = “yearly”)*

*employee\_tax\_liability(taxable\_income, period = “yearly”)*

*fetch\_tax\_data(infile)*

*gross\_income(gross\_salary, pension, nhis, nhf)*

*gross\_salary(…)*

*nhf\_deduction(gross\_salary, rate = 0.025)*

*nhis\_deduction(gross\_salary, rate = 0.05)*

*outstanding\_liability(actual\_employeeLiability, payment\_made)*

*penalty\_and\_interest(unpaid\_tax, due\_date, payment\_date,
employer\_type = “corporate”)*

*pension\_deduction(gross\_salary, rate = 0.08)*

*rent\_relief(rent\_paid)*

*sum\_cols(df, cols\_to\_sum)*

*taxable\_income(gross\_salary, total\_relief)*

*tax\_exemption(gross\_salary, rate)*

*total\_relief(cra\_value, pension, nhf, nhis)*

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
