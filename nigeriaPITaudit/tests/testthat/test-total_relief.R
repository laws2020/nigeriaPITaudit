test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("total_relief() correctly sums all components", {
  expect_equal(total_relief(1500000, 180000, 5750, 11500), 1697250)
  expect_equal(total_relief(1200000, 200000, 6000, 12000), 1418000)
  expect_equal(total_relief(1000000, 0, 0, 0), 1000000)
  expect_equal(total_relief(0, 0, 0, 0), 0)
})
