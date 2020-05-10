
#' @import units
NULL


# PLAN
# functions:
# as_css_units == as_units;
# set_css_units == set_units
# css_units<-
# css_units subclasses units? That way we can override e.g.
# `units<-.units`?
# Alternatively, we just return units and let the standard
# setters do their job
#
# SOURCES:
# css
#
# LaTeX
# https://raw.githubusercontent.com/debian-tex/texlive-bin/master/texk/web2c/pdftexdir/pdftex.web
#
# QUESTIONS
# https://www.w3.org/TR/css3-values/#absolute-lengths
# says "values are case-insensitive"... maybe have an option
# to lowercase all units on input?
#


#' Define ex = 0.5em
#'
#' @param on `TRUE`or `FALSE` to switch behaviour on or off.
#'
#' @details
#' By default the package makes no assumption about the value of the length unit
#' ex, which is font-dependent. Use this function to make an ex equal to
#' 0.5em.
#'
#' @export
#'
#' @examples
#' library(units)
#' install_css_units()
#' ex_half_em()
#' set_units(1, "em") + set_units(1, "ex")
#'
ex_half_em <- function (on = TRUE) {
  units::remove_symbolic_unit("ex")
  if (on) {
    units::install_conversion_constant("em", "ex", 2)
  } else {
    units::install_symbolic_unit("ex", dimensionless = FALSE)
  }
}


#' Install units for CSS
#'
#' @details
#' Source: https://www.w3.org/TR/css3-values/, 10 May 2020.
#'
#' Some units will be removed from the standard database, including
#' "pt" (pint), "t" (tonne), "pi" (the mathematical constant), "h" (hour),
#' "rem" (unit of radiation).
#'
#' @export
#'
#' @examples
#'
#' library(units)
#' install_css_units()
#' set_units(72, "pt") + set_units(1, "in")
install_css_units <- function () {
  units::remove_symbolic_unit("pt")  # pint
  units::remove_symbolic_unit("t")   # pt then becomes pico-tonnes :-D
  units::remove_symbolic_unit("pi")  # mathematical pi, breaks dpi
  units::remove_symbolic_unit("h")   # hour, breaks ch
  units::remove_symbolic_unit("rem") # 1/100 sievert

  units::install_conversion_constant("in", "pt", 72)
  units::install_conversion_constant("in", "px", 96)
  units::install_conversion_constant("mm", "Q", 4)
  units::install_conversion_constant("in", "pc", 6)


  units::install_conversion_constant("rad", "deg", 180/pi) # same as "arc_degree"

  viewport_length_units <- c("vw", "vh", "vmin", "vmax")
  font_length_units <- c("em", "ex", "ch", "rem")
  for (unit in c(viewport_length_units, font_length_units)) {
    units::install_symbolic_unit(unit, dimensionless = FALSE)
  }

  units::install_symbolic_unit("dpi", dimensionless = FALSE)
  units::install_conversion_constant("dpi", "dpcm", 1/2.54)
  units::install_conversion_constant("dpi", "dppx", 1/96)
  units::install_conversion_constant("dpi", "x", 1/96)
}


#' Install length units for LaTeX
#'
#' @param macros Boolean. Install some common LaTeX length macros such
#'   as `\\textwidth`?
#'
#' @details
#' Values are sourced from
#' https://raw.githubusercontent.com/debian-tex/texlive-bin/master/texk/web2c/pdftexdir/pdftex.web.
#'
#' Some units will be removed from the standard udunits database, including
#' "pt" (pint), "t" (tonne), "d" (day), "cc" (cubic centimeters), and
#' "u" (unit of atomic mass).
#'
#' @export
#'
#' @examples
#'
#' library(units)
#' install_latex_units()
#' set_units(72, "pt") + set_units(1, "in")
install_latex_units <- function (macros = FALSE) {
  stopifnot(is.logical(macros))

  units::remove_symbolic_unit("pt")
  units::remove_symbolic_unit("t")
  units::remove_symbolic_unit("d")  # day, breaks nd
  units::remove_symbolic_unit("cc") # cubic centimetres
  units::remove_symbolic_unit("u")  # atomic mass, breaks mu

  units::install_conversion_constant("in", "pt", 72.27)
  units::install_conversion_constant("pt", "pc", 1/12)
  units::install_conversion_constant("in", "bp", 72)
  units::install_conversion_constant("pt", "dd", 1157/1238)
  units::install_conversion_constant("dd", "cc", 1/12)
  units::install_conversion_constant("pt", "sp", 65536)
  units::install_conversion_constant("pt", "nd", 642/685)
  units::install_conversion_constant("nd", "nc", 1/12)

  font_length_units <- c("ex", "em", "mu")
  latex_length_units <- c(
          "\\baselineskip",
          "\\columnsep",
          "\\columnwidth",
          "\\evensidemargin",
          "\\linewidth",
          "\\oddsidemargin",
          "\\paperwidth",
          "\\paperheight",
          "\\parindent",
          "\\parskip",
          "\\tabcolsep",
          "\\textheight",
          "\\textwidth",
          "\\topmargin"
        )
  length_units <- font_length_units
  if (macros) length_units <- c(length_units, latex_length_units)
  for (unit in length_units) {
    units::install_symbolic_unit(unit, dimensionless = FALSE)
  }
}