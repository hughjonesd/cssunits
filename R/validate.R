
validate_css_units <- function (x) UseMethod("validate_css_units")


validate_latex_units <- function (x) UseMethod("validate_latex_units")

#' @export
validate_css_units.units <- function (x) {
  x <- as.character(units(x))
  NextMethod(object = x)
}
#' @export
validate_css_units.mixed_units <- validate_css_units.units


#' @export
validate_latex_units.units <- function (x) {
  x <- as.character(units(x))
  NextMethod(object = x)
}
#' @export
validate_latex_units.mixed_units <- validate_latex_units.units


#' @export
validate_css_units.default <- function (x) {
  ok <- x %in% css_unit_db$symbol
  if (! all(ok)) stop("Unrecognized css units:", paste(x[!ok], sep = ", "))
}


#' @export
validate_latex_units.default <- function (x) {
  ok <- x %in% c(latex_unit_db$symbol,latex_macro_db$symbol)
  if (! all(ok)) stop("Unrecognized latex units:", paste(x[!ok], sep = ", "))
}