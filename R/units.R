

#' @rdname set-css-latex-units
#' @export
#' @examples
#' x <- 1:3
#' css_units(x) <- "px"
#' x
`css_units<-` <- function (x, value) {
  validate_css_units(value)
  units(x) <- value

  x
}

#' @rdname set-css-latex-units
#' @export
`latex_units<-` <- function (x, value) {
  validate_latex_units(value)
  units(x) <- value

  x
}