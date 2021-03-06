
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cssunits

<!-- badges: start -->

[![R build
status](https://github.com/hughjonesd/cssunits/workflows/R-CMD-check/badge.svg)](https://github.com/hughjonesd/cssunits/actions)
[![Codecov test
coverage](https://codecov.io/gh/hughjonesd/cssunits/branch/master/graph/badge.svg)](https://codecov.io/gh/hughjonesd/cssunits?branch=master)
<!-- badges: end -->

cssunits allows you to use the R
[units](https://cran.r-project.org/package=units) library with CSS and
LaTeX widths.

## Installation

Install from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hughjonesd/cssunits")
```

## Example

``` r
library(cssunits)
library(units)
#> udunits system database from /usr/local/share/udunits
install_css_units()
set_units(72, "pt") + set_units(1, "in")
#> 144 [pt]
```
