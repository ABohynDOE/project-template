#' Generate a single report with all tables and all figures from the ToT
#' appearing in order of ID number

# Load required libraries
library(fs)
library(whisker)
library(glue)
library(cli)

# Global header for batch run
cli_h1("Generating global report")

# Path to the report file
report_path <- fs::path(
  "R", "reports",
  paste0("report_v", Sys.getenv("VERSION"), ".Rmd")
)

# Load the table of tables
tot_rds_file <- fs::path("Rdata", "tot.rds")
tot_data <- readRDS(tot_rds_file)

# Function to fill template and add to report
fill_template <- function(row, report) {
  # Determine template file based on type
  template_file <- fs::path("templates", glue("template-report-{row$Type}.Rmd"))

  # Check if template file exists
  if (!fs::file_exists(template_file)) {
    cli_alert_danger(
      "Template file '{template_file}' not found for Type '{row$Type}'."
    )
    return(NULL)
  }

  # Read template file
  template <- readr::read_lines(template_file)

  # Fill template with data from row
  filled_template <- whisker::whisker.render(
    template = template, data = row
  )

  # Display informative message
  cli_alert_info("{row$Type} {.strong {row$Name}} added to the report")

  # Add filled template to report
  report <- c(report, filled_template)
  return(report)
}

# Load the original structure of the report
report_template_path <- fs::path("templates", "template-report.Rmd")
report <- readr::read_lines(report_template_path)

# Apply fill_template function to each row of tot_data
for (row_number in seq_len(nrow(tot_data))) {
  report <- fill_template(tot_data[row_number, ], report)
}

# Write the complete report to file
readr::write_lines(x = report, file = report_path)
cli_alert_success("Full report file generated: {.path {report_path}}")
