
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


teardown({
  unloadNamespace("cssunits")
  unloadNamespace("units")
})
