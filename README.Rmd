---
output: github_document
---

# **nigeriaPITaudit**  
![GitHub](https://img.shields.io/github/license/laws2020/nigeriaPITaudit)  

### A Comprehensive Toolkit for Auditing Personal Income Tax in Nigeria  

## **Overview**
`nigeriaPITaudit` is an R package designed to streamline the auditing of personal income tax (PIT) in Nigeria. It assists tax auditors, accountants, and government agencies in evaluating tax compliance, identifying discrepancies, and ensuring adherence to Nigerian tax laws.

## **Features**
✔ Automated tax audit calculations based on Nigerian tax regulations  
✔ Data validation for tax records  
✔ Analysis of taxable income, deductions, and exemptions  
✔ Reporting tools for generating audit summaries  

---

## **Installation**  

### **Prerequisites**  
Ensure that R (version 4.0 or higher) and RStudio are installed.

### **Step 1: Install `devtools` (if not already installed)**  
```{r}
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

```

### Install nigeriaPITaudit from GitHub
```{r}
devtools::install_github("laws2020/nigeriaPITaudit/nigeriaPITaudit")

```


# The Birth of `nigeriaPITaudit`

## Chapter 1: A Journey Through Time

Five years ago, I worked in the auditing department with the **Internal Revenue Service (IRS)**. My main responsibility was conducting **payroll audits**—a task that required patience, accuracy, and mastery of financial tools.

After two years, my boss decided that my skills were needed elsewhere and I was transferred to a different department to handle what was considered **a more critical role** at the time. 

But something interesting happened. My former colleagues in the auditing department **kept coming to me** for help with payroll audits. Time and again, I reminded them, **"I have a new role now, and I can’t handle two responsibilities at once."** I encouraged them to **learn Excel** and take ownership of their work.

However, despite all my efforts, I still found myself handling **two roles**—whether I liked it or not. The annoying part is that even after I left the IRS, my former colleagues continued reaching out for help.

Their unwillingness to learn **pushed me to create something greater, but more easier to excel**. I wanted to empower them and others like them to perform payroll audits with ease. And so, the **`nigeriaPITaudit`** package was born—a tool designed to simplify payroll auditing in R!


## Chapter 2: Unlocking Payroll Secrets with `nigeriaPITaudit`

To embark on this journey, first, we must summon the power of nigeriaPITaudit package:


```{r}
library(nigeriaPITaudit)
library(knitr)
```


### Unveiling the Payroll Data

We retrieve the payroll data hidden in the nigeriaPITaudit archives:

```{r}
data("fmc2017")

```

Before proceeding, let’s inspect the structure of the dataset:

```{r}
str(fmc2017)

```

We now store it in a **data frame** for easy manipulation:

```{r}
df <- fmc2017

```

### Calculating Salary Components

To compute **gross salaries**, we use:

```{r}
gross <- gross_salary(df$Basic_Salary, df$Teaching_Allowance, df$Salary_Arrears,
                      df$other_allowances, df$Overtime, df$Shifting, df$Speacilist,
                      df$Hazard_Allowance)

```

### Deductions: Shielding Employees from Tax Burden

We then calculate key deductions:

```{r}
pension <- pension_deduction(gross)
nhf <- nhf_deduction(gross)
nhis <- nhis_deduction(gross)

```

### Computing Net Income and Tax Liabilities

We determine the **gross income**:

```{r}
grossIncome <- gross_income(gross, pension, nhis, nhf)

```

Applying **consolidated relief**:

```{r}
consolidatedRelief <- consolidated_relief(grossIncome, "monthly")

```

Total relief calculation:

```{r}
totalRelief <- total_relief(pension, nhis, nhf, consolidatedRelief)

```

Finally, we compute **taxable income** and **employee tax liability**:

```{r}
taxableIncome <- taxable_income(gross, totalRelief)
employeeLiability <- employee_tax_liability(taxableIncome, "monthly")

```


## Chapter 3: The Final Report

With all calculations complete, we compile a **comprehensive payroll tax report**:

```{r}
dftaxreport <- data.frame(
  Name = df$Name,  # Explicitly reference df$Name
  gross, pension, nhis, nhf, grossIncome, consolidatedRelief, 
  totalRelief, taxableIncome, employeeLiability
  
)
```

```{r}
columns_to_sum <- c("gross", "pension", "nhis", "nhf", "grossIncome", "consolidatedRelief", "totalRelief", "taxableIncome", "employeeLiability")
```

```{r}
result <- sum_cols(dftaxreport, columns_to_sum)
```

To summarize only the **first five and last five** records:


```{r}
library(knitr)

summary_result <- rbind(head(result, 5), tail(result, 5))

kable(summary_result, caption = "Summary of Personal Income Tax Audit")
```


## Chapter 4: Preserving the Knowledge

To ensure that our findings remain accessible, we store the results in an **Excel file**:

```{r}
library(writexl)
write_xlsx(summary_result, "C:/Users/Lawrence Daniel/Downloads/practiceAudit.xlsx")

```

And so, my journey from **IRS auditor** to **R package developer** comes full circle. With `nigeriaPITaudit`, anyone can now conduct payroll audits effortlessly.

This package is not just a tool—it’s my way of ensuring that **learning and self-sufficiency triumph over dependency**.

**Now, go forth and audit with confidence!** 


### Contributing
Contributions are welcome!

### How to Contribute
Fork the repository
Create a new branch (feature-new-functionality)
Commit your changes
Submit a Pull Request

For major changes, please open an issue first to discuss your proposed modifications.

###  License
This package is licensed under the MIT License. See the LICENSE file for more details.

###  Contact
For support or inquiries:
Email: laws.garba@gmail.com
GitHub Issues: Open an Issue
