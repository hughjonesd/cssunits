
#' @details
#' The "cssunits" package uses the "units" package to define a set of valid
#' CSS and/or LaTeX units. Some defaults from the udunits2 database are removed
#' so that they can be replaced by more appropriate units. For example, "pt"
#' refers to points and not to pints.
#'
#' To use it, run
#' ```
#' library(units)
#' library(cssunits)
#' install_css_units()
#' # or
#' install_latex_units()
#' ```
#' @keywords internal
"_PACKAGE"


#' This is data to be included in my package
#'
#' @name css_unit_db
#' @docType data
#' @author David Hugh-Jones <davidhughjones@gmail.com>
#' @references \url{https://www.w3.org/TR/css3-values/}
#' @keywords data
NULL

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
