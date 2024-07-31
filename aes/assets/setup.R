#########################################
# Set up and common commands & packages #
#########################################

# Sets default fonts for tikz
library(tikzDevice)
options(tikzLatexPackages=c(
  getOption("tikzLatexPackages"),"\\usepackage{inconsolata,}",
  "\\usepackage[scaled=.89]{helvet}\n\\renewcommand{\\familydefault}{\\sfdefault}\n")
)
options(tikzMetricPackages = c(
  "\\usepackage[utf8]{inputenc}","\\usepackage[T1]{fontenc}", "\\usetikzlibrary{calc}", "\\usepackage{amssymb}")
)

# Trick to automatically convert pdf graphs generated with dev='tikz' into png so they work in html format
# see: https://github.com/rstudio/bookdown/issues/275
# NB: Need to specify 'density=600' in 'image_read' to get same quality as tikz
knitr::opts_hooks$set(dev = function(options) {
  if (identical(options$dev, 'tikz') && !knitr:::is_latex_output()) {
    options$fig.process = function(x) {
      if (!grepl('[.]pdf$', x)) return(x)
      x2 = sub('pdf$', 'png', x)
      magick::image_write(magick::image_read(x,density=600), x2, format = 'png', quality=90, density=600)
      x2
    }
  }
  options
})

#' This makes the fonts play nicely within the figures
#' (but uses a weird font, not Arial, so can be turned off)
# knitr::opts_chunk$set(dev = "ragg_png")
# This sets up the overall options for computation output
knitr::opts_chunk$set(
  fig.width = 12, fig.height = 9, out.width = "55%", fig.align = "center"
)

