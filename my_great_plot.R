library(tidyverse)

iris <- iris

iris %>%
  ggplot(aes(x = Sepal.Length, y = Sepal.Width)) + geom_bin2d()

## This plot is not that great.