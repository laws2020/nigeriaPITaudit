test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})
library(testthat)

test_that("outstanding_liability computes correct values", {
  expect_equal(outstanding_liability(50000, 30000), 20000)
  expect_equal(outstanding_liability(c(50000, 60000, 55000), c(30000, 45000, 50000)), c(20000, 15000, 5000))
  expect_equal(outstanding_liability(0, 0), 0) # Edge case where liability and payment are zero
})

test_that("outstanding_liability handles incorrect input types", {
  expect_error(outstanding_liability("50000", 30000), "must be numeric values")
  expect_error(outstanding_liability(50000, "30000"), "must be numeric values")
  expect_error(outstanding_liability(c(50000, 60000), c(30000, "45000")), "must be numeric values")
})

test_that("outstanding_liability prevents negative values", {
  expect_error(outstanding_liability(-50000, 30000), "Values cannot be negative")
  expect_error(outstanding_liability(50000, -30000), "Values cannot be negative")
  expect_error(outstanding_liability(c(50000, -60000), c(30000, 45000)), "Values cannot be negative")
})

test_that("outstanding_liability prevents overpayment", {
  expect_error(outstanding_liability(50000, 60000), "Payment made cannot exceed actual liability")
  expect_error(outstanding_liability(c(50000, 60000), c(60000, 70000)), "Payment made cannot exceed actual liability")
})

test_that("outstanding_liability supports vectorized operations", {
  actual_liabilities <- c(100000, 50000, 25000)
  payments_made <- c(75000, 20000, 5000)
  expected_results <- c(25000, 30000, 20000)
  expect_equal(outstanding_liability(actual_liabilities, payments_made), expected_results)
})
