
none <- character(0)


css_percent_db <- data.frame(
  symbol     = "%",
  from_unit  = NA,
  multiplier = NA,
  new        = FALSE,
  remove     = I(list(none)),
  type       = "percent",
  stringsAsFactors = FALSE
)


css_length_db <- data.frame(
  symbol     = c("pt", "px", "Q", "pc", "in", "cm", "mm", "em", "ex", "ch",
                 "rem", "vw", "vh", "vmin", "vmax"),
  from_unit  = c("in", "in", "mm", "in", NA, NA, NA, NA, NA, NA,
                 NA, NA, NA, NA, NA),
  multiplier = c(72, 96, 4, 6, NA, NA, NA, NA, NA, NA,
                 NA, NA, NA, NA, NA),
  new        = c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE,
                 TRUE, TRUE, TRUE, TRUE, TRUE),
  remove     = I(list(c("pt", "t"), none, none, none, none, none, none, none, none, c("h"),
                 c("rem"), none, none, none, none)),
  type       = "length",
  stringsAsFactors = FALSE
)


css_angle_db <- data.frame(
  symbol     = c("deg", "grad", "rad", "turn"),
  from_unit  = c("rad", "rad", NA, NA),
  multiplier = c(180/pi, 200/pi, NA, NA),
  new        = c(TRUE, TRUE, FALSE, FALSE),
  remove     = I(list(c("arc_degree"), none, none, none)),
  type       = "angle",
  stringsAsFactors = FALSE
)


css_duration_db <- data.frame(
  symbol     = c("s", "ms"),
  from_unit  = NA,
  multiplier = NA,
  new        = FALSE,
  remove     = I(list(none, none)),
  type       = "duration",
  stringsAsFactors = FALSE
)


css_frequency_db <-data.frame(
  symbol     = c("Hz", "kHz"),
  from_unit  = NA,
  multiplier = NA,
  new        = FALSE,
  remove     = I(list(none, none)),
  type       = "frequency",
  stringsAsFactors = FALSE
)


css_resolution_db <- data.frame(
  symbol     = c("dpi", "dpcm", "dppx"),
  from_unit  = c(NA, "dpi", "dpi"),
  multiplier = c(NA, 1/2.54, 1/96),
  new        = c(TRUE, TRUE, TRUE),
  remove     = I(list(c("pi"), none, none)),
  type       = "resolution",
  stringsAsFactors = FALSE
)


css_unit_db <- rbind(css_percent_db, css_length_db, css_angle_db, css_duration_db,
  css_frequency_db, css_resolution_db)


latex_unit_db <- data.frame(
  symbol     = c("pt", "pc", "bp", "dd", "cc", "sp", "nd", "nc", "in", "cm", "mm",
                 "ex", "em", "mu", "px"),
  from_unit  = c("in", "pt", "pt", "pt", "pt", "pt", "pt", "pt", NA  , NA,   NA,
                 NA, NA, NA, "bp"),
  multiplier = c(72.27, 1/12, 72/72.27, 1157/1238, 1157/14856, 65536, 642/685, 107/1370, NA, NA, NA,
                 NA, NA, NA, 1),
  new        = c(TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE,
                 TRUE, TRUE, TRUE, TRUE),
  remove     = I(list(c("pt", "t"), none, none, c("d"), c("cc"), none, c("d"), none, none, none, none,
                 none, none, c("u"), none)),
  type       = "length",
  stringsAsFactors = FALSE
)


latex_length_macros <- c(
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


latex_macro_db <- data.frame(
  symbol     = latex_length_macros,
  from_unit  = NA,
  multiplier = NA,
  new        = TRUE,
  remove     = I(rep(list(none), length(latex_length_macros))),
  type       = "length",
  stringsAsFactors = FALSE
)


usethis::use_data(css_unit_db, latex_unit_db, latex_macro_db,
      overwrite = TRUE, compress = FALSE, internal = TRUE)
