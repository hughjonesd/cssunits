
#' Import units from CSS or LaTeX character vectors.
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
#' @name from-css-latex
NULL


#' @export
#' @rdname from-css-latex
from_css <- function (x) {
  numbers <- sub("^(.*?)(\\D+)$", "\\1", x, perl = TRUE)
  units <- sub("^(.*?)(\\D+)$", "\\2", x, perl = TRUE)
  numbers <- as.numeric(numbers)

  units <- canonicalize_css_units(units)
  validate_css_units(units)
  if (any(invalid <- is.na(numbers))) {
    stop("Invalid numbers found: ", numbers[invalid])
  }

  mixed_units(numbers, units, mode = "standard")
}


canonicalize_css_units <- function (x) {
  x <- tolower(x)
  x[x == "q"] <- "Q"
  x[x == "hz"] <- "Hz"
  x[x == "khz"] <- "kHz"

  x
}


#' @export
#' @rdname from-css-latex
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
