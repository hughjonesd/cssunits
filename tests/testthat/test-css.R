
setup({
  library(units)
  library(cssunits)
  install_css_units()
})


test_that("basic usage", {
  for (symbol in css_unit_db$symbol) {
    expect_silent(set_units(1, symbol, mode = "standard"))
  }
})


test_that("length additions", {
  expect_equal(set_units(1, "in") + set_units(72, "pt"), set_units(2, "in"))
  expect_equal(set_units(1, "in") + set_units(96, "px"), set_units(2, "in"))
  expect_equal(set_units(1, "in") + set_units(6, "pc"), set_units(2, "in"))
  expect_equal(set_units(1, "mm") + set_units(4, "Q"), set_units(2, "mm"))
  expect_equal(set_units(1, "in") + set_units(96, "px"), set_units(2, "in"))
})


test_that("ex_half_em", {
  expect_error(set_units(1, "ex") + set_units(1, "em"))
  ex_half_em(TRUE)
  expect_equal(set_units(1, "ex") + set_units(1, "em"), set_units(3, "ex"))
  ex_half_em(FALSE)
  expect_error(set_units(1, "ex") + set_units(1, "em"))
})


test_that("angle additions", {
  expect_equal(set_units(360, "deg") + set_units(2 * pi, "rad"),
    set_units(720, "deg"))
})


test_that("resolution additions", {
  expect_equal(set_units(96, "dpi") + set_units(1, "dppx"),
        set_units(192, "dpi"))
  expect_equal(set_units(1, "dpi") + set_units(1, "dpcm"),
        set_units(3.54, "dpi"))
})




teardown({
  unloadNamespace("cssunits")
  unloadNamespace("units")
})
