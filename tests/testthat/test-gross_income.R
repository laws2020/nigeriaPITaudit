test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

# Unit tests for gross_income function
test_that("gross_income correctly computes gross income after deductions", {
  # Test case 1: Standard calculation with valid numeric inputs
  expect_equal(gross_income(2300000, 184000, 11500, 5750), 2098750)

  # Test case 2: No deductions, Gross Income should be equal to Gross Salary
  expect_equal(gross_income(3000000, 0, 0, 0), 3000000)

  # Test case 3: Handling zero Gross Salary with deductions (should return a negative value)
  expect_equal(gross_income(0, 10000, 5000, 2000), -17000)

  # Test case 4: Handling negative deductions (should increase Gross Income)
  expect_equal(gross_income(1000000, -50000, -10000, -5000), 1065000)

  # Test case 5: Large numbers handling
  expect_equal(gross_income(1e8, 2e6, 1e6, 5e5), 96500000)

  # Test case 6: Floating point inputs
  expect_equal(gross_income(150000.75, 5000.50, 2500.25, 1250.25), 141249.75)

  # Test case 7: Non-numeric inputs should trigger an error
  expect_error(gross_income("2300000", 184000, 11500, 5750), "non-numeric")
  expect_error(gross_income(2300000, "184000", 11500, 5750), "non-numeric")

  # Test case 8: Missing arguments should trigger an error
  expect_error(gross_income(2300000, 184000, 11500), "argument \"nhf\" is missing")
  expect_error(gross_income(2300000, 184000), "argument \"nhis\" is missing")
  expect_error(gross_income(2300000), "argument \"pension\" is missing")
  expect_error(gross_income(), "argument \"gross_salary\" is missing")
})
