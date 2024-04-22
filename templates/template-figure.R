## FIGURE ##
#' Name: {{Name}}
#' Date: {{Date}}
#' Title: {{Title}}

# Load required packages
library(ggplot2)
library(dplyr)

# Load required data
data <- readRDS()

# Generate the plot
plot <- ggplot()

# Save plot to png file
plot_name <- gsub("\\.R$", "", "{{Name}}")
plot_file <- fs::path("results", "figures", paste0(plot_name, ".png"))
ggsave(
  filename = plot_file,
  plot = plot,
  width = 8,
  height = 5,
  dpi = 300
)

# Output path of generated program
cli::cli_alert_success(
  "Figure {.strong {plot_name}} saved to {.path {plot_file}}"
)
