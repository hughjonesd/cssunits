
setup({
  library(units)
  library(cssunits)
  install_latex_units(macros = TRUE)
})

test_that("basic usage", {
  for (symbol in latex_unit_db$symbol) {
    expect_silent(set_units(1, symbol, mode = "standard"))
  }
})


test_that("length additions", {
  # directly from the source at
  # https://raw.githubusercontent.com/debian-tex/texlive-bin/master/texk/web2c/pdftexdir/pdftex.web
  expect_equal(set_units(1, "pt") + set_units(1, "cm"),
        set_units(1 + 7227/254, "pt"))
  expect_equal(set_units(1, "pt") + set_units(1, "bp"),
        set_units(1 + 7227/7200, "pt"))
  expect_equal(set_units(1, "pt") + set_units(1, "dd"),
        set_units(1 + 1238/1157, "pt"))
  expect_equal(set_units(1, "pt") + set_units(1, "cc"),
        set_units(1 + 14856/1157, "pt"))
  expect_equal(set_units(1, "pt") + set_units(1, "nd"),
        set_units(1 + 685/642, "pt"))
  expect_equal(set_units(1, "pt") + set_units(1, "nc"),
        set_units(1 + 1370/107, "pt"))
})


test_that("set_latex_units", {
  expect_equal(set_latex_units(1, "bp"), set_units(1, "bp"))
  expect_equal(set_latex_units(1, bp), set_units(1, "bp"))
  expect_error(set_latex_units(1, "m"))
  expect_error(set_latex_units(1, m))
})


test_that("from_latex", {
  bp <- set_units(12, "bp")
  bp <- mixed_units(bp)

  expect_equal(from_latex("12bp"), bp)
  expect_equal(from_latex("12 bp"), bp)
  expect_equal(from_latex(" 12 bp"), bp)
  expect_equal(from_latex("+12 bp"), bp)
  expect_equal(from_latex(" + 12 bp "), bp)
  expect_equal(from_latex(" - 12.5 bp"), mixed_units(-12.5, "bp"))

  expect_error(from_latex("1m"))
  expect_error(from_latex("1e2 bp"))
  expect_error(from_latex("1 2 bp"))
  expect_error(from_latex("12 b p"))

  expect_equal(
          from_latex(c("12bp", "1em")),
          mixed_units(c(12, 1), c("bp", "em"))
        )
})


test_that("as_latex", {
  x <- set_latex_units(1:3, "em")
  expect_identical(as_latex(x), paste0(1:3, "em"))
  m <- mixed_units(1:3, c("em", "bp", "dd"))
  expect_identical(as_latex(m), c("1em", "2bp", "3dd"))
})


teardown({
  unloadNamespace("cssunits")
  unloadNamespace("units")
})
