## TABLE ##
#' Name: {{Name}}
#' Date: {{Date}}
#' Title: {{Title}}

# Load required packages
library(officer)
library(flextable)
library(dplyr)

# Load required data
data <- readRDS()

# Generate the table
table <- flextable()

# Define properties of the word file for the table
ps <- prop_section(
  page_size = page_size(orient = "landscape"),
  page_margins = page_mar(top = 1, bottom = 1)
)

# Save plot to word file with caption from the template data
table_name <- gsub("\\.R$", "", "{{Name}}")
table_file <- fs::path("results", "tables", paste0(table_name, ".docx"))
table |>
  flextable::set_caption("{{Title}}") |>
  flextable::save_as_docx(path = table_file, pr_section = ps)

# Save the table data as `rds` file
table_data <- fs::path("Rdata", "tables", paste0(table_name, ".rds"))
saveRDS(object = table, file = table_data)

# Output path of generated program
cli::cli_alert_success(
  "Table {.strong {table_name}} saved to {.path {table_file}}"
)
cli::cli_alert_success(
  "Table data saved to {.path {table_data}}"
)
