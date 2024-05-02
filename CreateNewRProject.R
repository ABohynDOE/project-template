library(cli)
require(fs)


# Main function to create a new R project
create_new_r_project <- function() {
  # Prompt user for project name
  cat("Enter project name: ")
  project_name <- readline()

  # Check validity of project name
  if (!stringr::str_detect(project_name, "^[a-z0-9A-Z-_\\s]+$")) {
    rlang::abort(
      c(
        "Invalid project name",
        "Can only contain letters, numbers, spaces, hyphens, and underscores"
      )
    )
  }

  # Prompt user for project directory name
  cat("Enter project directory name: ")
  project_directory_name <- readline()

  # Check validity of project name
  if (!stringr::str_detect(project_directory_name, "^[a-z0-9A-Z-_]+$")) {
    rlang::abort(
      c(
        "Invalid project directory name",
        "Can only contain letters, numbers, hyphens, and underscores"
      )
    )
  }

  # Prompt user for project path
  cat("Enter project path: ")
  project_path <- fs::path(readline())

  # Check that the project path exists
  if (!fs::dir_exists(project_path)) {
    rlang::abort("Project path {.path {project_path} does not exist")
  }

  # Check that the full project path does not exist yet
  project_directory <- fs::path(project_path, project_directory_name)
  if (fs::dir_exists(project_directory)) {
    cli_abort(
      "Directory {project_directory_name}  already exists at {.path {project_path}}"
    )
  }

  # Copy the template folder in the project path
  template_path <- fs::path("C:\\Users\\u0133728\\Documents\\project-template")
  fs::dir_copy(template_path, project_path)

  # Rename the new project directory accordingly
  fs::file_move(
    path = fs::path(project_path, "project-template"),
    new_path = project_directory
  )

  # Delete the .git folder and .R
  fs::dir_delete(fs::path(project_directory, ".Rproj.user"))
  fs::dir_delete(fs::path(project_directory, ".git"))

  # Rename the `.Rproj` file with the project name
  fs::file_move(
    path = fs::path(project_directory, "project-template.Rproj"),
    new_path = fs::path(project_directory, glue::glue("{project_name}.Rproj"))
  )

  # Change project name in .Renviron
  renviron <- readLines(fs::path(project_directory, ".Renviron"))
  renviron[1] <- glue::glue('PROJECT_NAME = "{project_name}"')
  writeLines(renviron, fs::path(project_directory, ".Renviron"))

  # Change project name in .Renviron
  readme <- readLines(fs::path(project_directory, "README.md"), -1)
  readme[1] <- glue::glue("# {project_name}")
  writeLines(readme, fs::path(project_directory, "README.md"))

  # Delete this script from the new folder
  fs::file_delete(fs::path(project_directory, "CreateNewRProject.R"))

  cli_alert_success("Project setup complete!")
  cli_alert_info("New project created at {.path {project_directory}}")
}


create_new_r_project()
