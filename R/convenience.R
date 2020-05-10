
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
#' @name set-units
NULL


#' @export
#' @rdname set-units
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
#' @rdname set-units
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


#' Create units from CSS or LaTeX dimensions
#'
#' @param x A character vector.
#'
#' @return An object of class "mixed_units".
#'
#' @examples
#'
#' unloadNamespace("cssunits")
#' unloadNamespace("units")
#' library(cssunits)
#' install_css_units()
#'
#' from_css(c("3em", "14px"))
#'
#' @name units-from-strings
NULL


#' @export
#' @rdname units-from-strings
from_css <- function (x) {
  numbers <- sub("^(.*?)(\\D+)$", "\\1", x, perl = TRUE)
  units <- sub("^(.*?)(\\D+)$", "\\2", x, perl = TRUE)
  numbers <- as.numeric(numbers)

  validate_css_units(units)
  if (any(invalid <- is.na(numbers))) {
    stop("Invalid numbers found: ", numbers[invalid])
  }

  mixed_units(numbers, units, mode = "standard")
}


#' @export
#' @rdname units-from-strings
from_latex <- function (x) {
  # "Blank spaces are optional before the signs and the numbers and the units of
  # measure, and you can also put an optional space after the dimension; but you
  # should not put spaces within the digits of a number or between the letters
  # of the unit of measure." - TeXBook
  regex <- "^\\s*(.*?)\\s*(\\D+?)\\s*$"
  numbers <- sub(regex, "\\1", x, perl = TRUE)
  units <- sub(regex, "\\2", x, perl = TRUE)

  exps <- grepl("e", numbers, ignore.case = TRUE)
  if (any(exps)) {
    stop("Found forbidden exponent in LaTeX strings: ", x[exps])
  }
  numbers <- sub(",", ".", numbers, fixed = TRUE)
  # TeX but not R allows a space between the space and the numbers.
  # We remove it.
  numbers <- sub("(\\+|-)\\s+(\\d+)", "\\1\\2", numbers, perl = TRUE)

  validate_latex_units(units)
  numbers <- as.numeric(numbers)
  if (any(invalid <- is.na(numbers))) {
    stop("Invalid numbers found: ", numbers[invalid])
  }

  mixed_units(numbers, units, mode = "standard")
}


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


