#' Run all R scripts in the `R/figures/` folder

# Load required libraries
library(fs)
library(cli)

# Global header for batch run
cli_h1("Rendering figures")

# Define directory containing figure programs
figures_dir <- fs::path("R", "figures")

# List all files in the figures directory
figure_files <- fs::dir_ls(figures_dir)

# Function to run figure files
run_figures <- function(files) {
  # Total number of figures to run
  num_figures <- length(figure_files)

  # Stop if no tables
  if (num_figures == 0) {
    cli_alert_warning("No figures found")
    return(invisible())
  }

  # General progress message for all tables
  cli_progress_bar(
    name = "Generating figures",
    total = num_figures,
    clear = FALSE
  )

  for (i in 1:num_figures) {
    # Generate the table and suppress the output
    suppressMessages(source(files[i]))

    # Message to inform completion of the current table
    cli_alert_info("Figure {i} done: {.path {files[i]}}")
    cli_progress_update()
  }
}

# Run figure files
run_figures(figure_files)
