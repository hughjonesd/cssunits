
#' @import units
NULL


#' @name how-to-remove
#' @section Removing:
#' These functions install incompatible versions of some units, e.g. CSS points
#' are not the same as LaTeX points. They are also not idempotent: calling
#' them twice will probably generate an error.
#' To return to the pristine udunits2 database, use
#'
#' ```
#' unloadNamespace("cssunits")
#' unloadNamespace("units")
#' library(units)
#' ```
NULL


#' Install units for CSS
#'
#' @details
#' Some units will be removed from the standard database, including
#' "pt" (pint), "t" (tonne), "pi" (the mathematical constant), "h" (hour),
#' "rem" (unit of radiation).
#'
#' @inheritSection how-to-remove Removing
#'
#' @export
#'
#' @examples
#'
#' library(units)
#' install_css_units()
#' set_units(1, "in") + set_units(72, "pt")
#'
install_css_units <- function () {
  install_units_from_db(css_unit_db)
}


#' Install length units for LaTeX
#'
#' @param macros Boolean. Install some common LaTeX length macros such
#'   as `\\textwidth`?
#'
#' @details
#' Some units will be removed from the standard udunits database, including
#' "pt" (pint), "t" (tonne), "d" (day), "cc" (cubic centimeters), and
#' "u" (unit of atomic mass).
#'
#' @inheritSection how-to-remove Removing
#'
#' @export
#'
#' @examples
#'
#' library(units)
#' install_latex_units()
#' set_units(1, "in") + set_units(72.27, "pt")
#'
install_latex_units <- function (macros = FALSE) {
  stopifnot(is.logical(macros))

  install_units_from_db(latex_unit_db)
  if (macros) install_units_from_db(latex_macro_db)
}


install_units_from_db <- function (db) {
  removed <- character(0)
  for (r in seq_len(nrow(db))) {
    un <- db[r, ]

    # odd subsetting below is required to pluck characters out of list-column
    for (to_remove in un[[1, "remove"]]) {
      if (! to_remove %in% removed) {
        units::remove_symbolic_unit(to_remove)
      }
      removed <- c(removed, to_remove)
    }

    if (un$new) {
      if (is.na(un$from_unit)) {
        units::install_symbolic_unit(un$symbol, warn = TRUE, dimensionless = FALSE)
      } else {
        units::install_conversion_constant(un$from_unit, un$symbol, un$multiplier)
      }
    }
  }
}


#' Define ex = 0.5em
#'
#' @param on `TRUE` or `FALSE` to switch behaviour on or off.
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
  stopifnot(is.logical(on))

  units::remove_symbolic_unit("ex")
  if (on) {
    units::install_conversion_constant("em", "ex", 2)
  } else {
    units::install_symbolic_unit("ex", dimensionless = FALSE)
  }
}