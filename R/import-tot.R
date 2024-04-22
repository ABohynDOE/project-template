# Import the excel file containing the table of tables into a R data set for
# later use

# Load required libraries
library(readxl)
library(cli)
library(fs)

# Global header for batch run
cli_h1("Importing ToT")

# Function to import table of tables
import_tot <- function() {
  # File paths
  tot_excel_file <- fs::path("data", "tot", "table-of-tables.xlsx")
  tot_rds_file <- fs::path("Rdata", "tot.rds")

  # Import Excel file
  tot_data <- readxl::read_excel(tot_excel_file)

  # Check for uniqueness of program names
  non_unique_prog <- duplicated(tot_data$Name)

  if (any(non_unique_prog)) {
    non_unique_prog_names <- unique(
      tot_data$Name[non_unique_prog]
    )
    cli::cli_alert_danger(
      "Non-unique program names found: {.val {non_unique_prog_names}}",
      wrap = TRUE
    )
    return(invisible())
  }

  # Check for invalid characters in Name
  invalid_names <- grep("[^[:alnum:_-]]", tot_data$Name)
  if (length(invalid_names) > 0) {
    invalid_name_values <- unique(tot_data$Name[invalid_names])
    cli::cli_alert_danger(
      "Invalid characters found in Name: {.val {invalid_name_values}}"
    )
    return(invisible())
  }

  # Check for uniqueness of table of tables IDs
  non_unique_id <- duplicated(tot_data$ID)

  if (any(non_unique_id)) {
    non_unique_id_values <- unique(
      tot_data$ID[non_unique_id]
    )
    cli::cli_alert_danger(
      "Non-unique IDs found: {.val {non_unique_id_values}}",
      wrap = TRUE
    )
    return(invisible())
  }

  # Check for valid Type values
  valid_types <- c("figure", "table")
  invalid_types <- !(tot_data$Type %in% valid_types)
  if (any(invalid_types)) {
    invalid_type_values <- unique(tot_data$Type[invalid_types])
    cli::cli_alert_danger(
      "Invalid program types found: {.val {invalid_type_values}}"
    )
    return(invisible())
  }

  # Save as .rds file
  saveRDS(tot_data, tot_rds_file)

  # Output path of imported R data set using cli alert_success
  cli::cli_alert_success(
    "Table of tables imported successfully to {.path {tot_rds_file}}"
  )

  # Output number of tables and figures
  num_tables <- sum(tot_data$Type == "table")
  num_figures <- sum(tot_data$Type == "figure")
  cli::cli_alert("Found {num_tables} table{?s} and {num_figures} figure{?s}")
}

# Run the import function
import_tot()
