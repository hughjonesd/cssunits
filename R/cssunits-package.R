
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


#' Data frame of CSS and LaTeX units
#'
#' The package exports three data frames:  `css_unit_db`,
#' `latex_unit_db` and `latex_macro_db`.
#'
#' The format is not the same as the udunits2 database. Rows are:
#'
#' * `symbol`: symbol, e.g. "pt"
#' * `from_unit`: unit on which the new unit is based, or `NA`
#' * `new`: is unit new or already defined in udunits2?
#' * `remove`: list-column of conflicting units to remove from udunits2
#' * `type`: one of percent, length, angle, duration, frequency, resolution
#'
#' Some units are redefined by "cssunits" so as to use a new
#' symbol. For example, "arc_degree" is present in udunits2, but it is replaced
#' by a new "deg" unit here.
#'
#' @name css_unit_db
#' @export
#' @docType data
#' @author David Hugh-Jones <davidhughjones@gmail.com>
#' @references
#' * \url{https://www.w3.org/TR/css3-values/}
#' * \url{https://raw.githubusercontent.com/debian-tex/texlive-bin/master/texk/web2c/pdftexdir/pdftex.web}
#' @keywords data
NULL


#' @name latex_unit_db
#' @rdname css_unit_db
#' @export
NULL


#' @name latex_macro_db
#' @rdname css_unit_db
#' @export
NULL


# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
