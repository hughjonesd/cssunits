
#' Export units as CSS/LaTeX
#'
#' These functions throw an error if `units(x)` is not a valid CSS/LaTeX unit.
#' @param x An object of class `units`` or `mixed_units`
#' @return A character vector.
#' @examples
#'
#' unloadNamespace("cssunits")
#' unloadNamespace("units")
#' library(cssunits)
#' install_css_units()
#'
#' x <- set_css_units(1:3, "pt")
#' as_css(x)
#'
#' @name as-css-latex
NULL

#' @export
#' @rdname as-css-latex
as_css <- function (x) UseMethod("as_css")


#' @export
#' @rdname as-css-latex
as_latex <- function (x) UseMethod("as_latex")


#' @export
as_css.units <- function (x) {
  validate_css_units(x)
  paste0(x, units(x))
}
#' @export
as_css.mixed_units <- as_css.units


#' @export
as_latex.units <- function (x) {
  validate_latex_units(x)
  paste0(x, units(x))
}
#' @export
as_latex.mixed_units <- as_latex.units
