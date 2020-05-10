
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


test_that("css_units<-", {
  x <- 1
  css_units(x) <- "px"
  expect_equal(x, set_units(1, "px"))
  y <- 1
  expect_error(css_units(y) <- "m")
})


test_that("set_css_units", {
  expect_equal(set_css_units(1, "dpi"), set_units(1, "dpi"))
  expect_equal(set_css_units(1, dpi), set_units(1, "dpi"))
  expect_error(set_css_units(1, "m"))
  expect_error(set_css_units(1, m))
})


test_that("from_css", {
  deg <- mixed_units(180, "deg")
  deg0.1 <- mixed_units(0.1, "deg")
  degmin90 <- mixed_units(-90, "deg")

  expect_equal(from_css("180deg"), deg)
  # case doesn't matter in CSS
  expect_equal(from_css("180DEG"), deg)
  expect_equal(from_css("+180deg"), deg)
  expect_equal(from_css("180e0deg"), deg)
  expect_equal(from_css("0.1deg"), deg0.1)
  expect_equal(from_css("+1e-1deg"), deg0.1)
  expect_equal(from_css("-90deg"), degmin90)

  expect_error(from_css("1m"))
  expect_error(from_css("1 deg"))
  expect_error(from_css("1 2 deg"))
  expect_error(from_css("12 d eg"))

  expect_equal(
          from_css(c("1em", "12pt")),
          mixed_units(c(1, 12), c("em", "pt"))
        )
})


test_that("as_css", {
  x <- set_css_units(1:3, "em")
  expect_identical(as_css(x), paste0(1:3, "em"))
  m <- mixed_units(1:3, c("em", "dpi", "pt"))
  expect_identical(as_css(m), c("1em", "2dpi", "3pt"))
})


teardown({
  unloadNamespace("cssunits")
  unloadNamespace("units")
})
