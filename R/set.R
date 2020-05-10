
#' Set CSS/LaTeX units
#'
#' These functions check that units are legitimate CSS/LaTeX units, then
#' call [units::set_units()].
#'
#' @param x,value,...,mode See [units::set_units()]
#'
#' @return An object of class units. Throws an error if the unit specification
#' is not recognized.
#'
#' @examples
#'
#' unloadNamespace("cssunits")
#' unloadNamespace("units")
#' library(cssunits)
#'
#' install_css_units()
#' set_css_units(1, "px", mode = "standard")
#' set_css_units(1, px)
#' # catching errors:
#' try(set_css_units(1, pox))
#'
#' @name set-css-latex-units
NULL


#' @export
#' @rdname set-css-latex-units
set_css_units <- function (
        x,
        value,
        ...,
        mode = units_options("set_units_mode")
      ) {
  if (mode == "symbols") value <- as.character(substitute(value))
  validate_css_units(value)
  set_units(x, value, ..., mode = "standard")
}


#' @export
#' @rdname set-css-latex-units
set_latex_units <- function (
        x,
        value,
        ...,
        mode = units_options("set_units_mode")
      ) {
  if (mode == "symbols") value <- as.character(substitute(value))
  validate_latex_units(value)
  set_units(x, value, ..., mode = "Standard")
}
