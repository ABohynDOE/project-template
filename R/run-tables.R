#' Run all R scripts in the `R/tables/` folder

# Load required libraries
library(fs)
library(cli)

# Global header for batch run
cli_h1("Rendering tables")

# Define directory containing table programs
tables_dir <- fs::path("R", "tables")

# List all files in the tables directory
table_files <- fs::dir_ls(tables_dir)

# Function to run table files
run_tables <- function(files) {
  # Total number of tables to run
  num_tables <- length(files)

  # Stop if no tables
  if (num_tables == 0) {
    cli_alert_warning("No tables found")
    return(invisible())
  }

  # General progress message for all tables
  cli_progress_bar(
    name = "Generating tables",
    total = num_tables,
    clear = FALSE
  )

  for (i in 1:num_tables) {
    # Generate the table and suppress the output
    suppressMessages(source(files[i]))

    # Message to inform completion of the current table
    cli_alert_info("Table {i} done: {.path {files[i]}}")
    cli_progress_update()
  }
}

# Run table files
run_tables(table_files)
