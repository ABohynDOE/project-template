#' Render the Rmarkdown file containing the report and output the report to docx

# Load required packages
library(cli)

# Global header for batch run
cli_h1("Rendering global report")

report_rmd_path <- paste0("R/reports/report_v", Sys.getenv("VERSION"), ".Rmd")
report_docx_file <- paste0(
  "../../results/reports/report_v",
  Sys.getenv("VERSION"),
  "_",
  Sys.Date(),
  ".docx"
)
rmarkdown::render(
  input = report_rmd_path,
  output_file = report_docx_file
)