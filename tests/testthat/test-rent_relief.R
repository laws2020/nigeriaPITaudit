test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

# Load the testthat package
library(testthat)
library(nigeriaPITaudit)  # Load your package (replace with actual name)

test_that("Rent relief calculations are correct", {
  expect_equal(rent_relief(500000), 100000)  # 20% of 500K is 100K
  expect_equal(rent_relief(2000000), 200000) # Capped at 200K
  expect_equal(rent_relief(1000000), 200000) # Capped at 200K
  expect_equal(rent_relief(100000), 20000)   # 20% of 100K is 20K
  expect_equal(rent_relief(0), 0)            # No rent, no deduction
})
