test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("gross_salary correctly calculates total earnings", {
  df <- data.frame(
    BasicSalary = c(500000, 600000),
    RiskAllowance = c(20000, 25000),
    Bonus = c(100000, 120000),
    stringsAsFactors = FALSE
  )

  gross_emol <- gross_salary(df$BasicSalary, df$RiskAllowance, df$Bonus)

  expect_equal(gross_emol[1], 620000)  # Confirm computed sum is correct
  expect_equal(gross_emol[2], 745000)
})

test_that("gross_salary handles NA values correctly", {
  df <- data.frame(
    BasicSalary = c(3000000, 2500000),
    RiskAllowance = c(NA, 200000),
    Bonus = c(500000, NA),
    stringsAsFactors = FALSE
  )

  gross_emol <- gross_salary(df$BasicSalary, df$RiskAllowance, df$Bonus)

  expect_equal(gross_emol[1], 3500000)  # 3000000 + 500000 = 3500000
  expect_equal(gross_emol[2], 2700000)  # 2500000 + 200000 = 2700000
})

test_that("gross_salary throws an error for non-numeric input", {
  expect_error(gross_salary("not_numeric", 40000, 200000),
               regexp = "All inputs must be numeric.")
})

# REMOVE this test if your function allows negative values
test_that("gross_salary throws an error for negative values", {
  expect_error(gross_salary(-100000, 30000, 150000),
               regexp = "Salary and bonus cannot be negative.")
})
