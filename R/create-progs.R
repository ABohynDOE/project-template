# Generate all scripts listed in the table of tables based on the templates for
# tables and figures in the `templates` folder

# Load required libraries
library(fs)
library(whisker)
library(cli)
library(glue)
library(readr)

# Global header for batch run
cli_h1("Generating R programs")

# Load tot.rds file
rds_file <- fs::path("Rdata", "tot.rds")
tot_data <- readRDS(rds_file)

# Define output directory for generated programs
output_dir <- fs::path("R")

# Function to generate program based on template
generate_program <- function(template, output_file, data) {
  # Check if the output file already exists
  if (fs::file_exists(output_file)) {
    cli::cli_alert_warning(
      "Skipped {.strong {data$Type}} {data$ID}: '{.path {output_file}}' already exists."
    )
    return(invisible())
  }

  # Add the current date to the template data
  data$Date <- format(Sys.Date(), "%Y-%b-%d")

  # Generate program using whisker
  rendered_program <- whisker::whisker.render(
    template = template,
    data = data
  )

  # Write program to file
  readr::write_lines(
    x = rendered_program,
    file = output_file,
    sep = "\n"
  )

  # Output path of generated program
  cli::cli_alert_success(
    "Generated {.strong {data$Type}} {data$ID}: {.path {output_file}}"
  )
}

# Iterate through each row in tot data and generate program
for (i in seq_len(nrow(tot_data))) {
  # Get information from the current row
  prog_name <- tot_data$Name[i]
  # All programs should end in `.R`
  if (!grepl("\\.R$", prog_name)) {
    prog_name <- paste0(prog_name, ".R")
  }
  type <- tolower(tot_data$Type[i])
  template_file <- fs::path("templates", glue("template-{type}.R"))
  output_file <- fs::path(output_dir, paste0(type, "s"), prog_name)

  # Check if the template file exists
  if (!fs::file_exists(template_file)) {
    cli::cli_alert_danger("Template file '{.path {template_file}}' not found.")
    next
  }

  # Read template file
  template <- readr::read_file(template_file)

  # Generate program
  generate_program(template, output_file, tot_data[i, ])
}
