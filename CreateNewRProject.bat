@echo off
setlocal enabledelayedexpansion

REM Main function to create a new R project
call :create_new_r_project
goto :eof

:create_new_r_project
REM Prompt user for project name
set /p project_name=Enter project name: 

REM Check validity of project name
echo !project_name! | findstr /r "^[a-zA-Z0-9-_ ]*$" >nul || (
    echo Invalid project name !
    echo Can only contain letters, numbers, spaces, hyphens, and underscores
    exit /b
)

REM Prompt user for project directory name
set /p project_directory_name=Enter project directory name: 

REM Check validity of project directory name
echo !project_directory_name! | findstr /r "^[a-zA-Z0-9-_]*$" >nul || (
    echo Invalid project directory name
    echo Can only contain letters, numbers, hyphens, and underscores
    exit /b
)

REM Prompt user for project path
set /p project_path=Enter project path: 

REM Check that the project path exists
if not exist "!project_path!" (
    echo Project path !project_path! does not exist
    exit /b
)

REM Check that the full project path does not exist yet
set project_directory=!project_path!\!project_directory_name!
if exist "!project_directory!" (
    echo Directory !project_directory_name! already exists at !project_path!
    exit /b
)

REM Copy the template folder to the project path
xcopy /s /e /i "C:\Users\u0133728\Documents\project-template" "!project_path!"

REM Rename the new project directory accordingly
rename "!project_path!\project-template" "!project_directory_name!"

REM Delete the .git folder and .Rproj.user
rmdir /s /q "!project_directory!\.Rproj.user"
rmdir /s /q "!project_directory!\.git"

REM Rename the .Rproj file with the project name
rename "!project_directory!\project-template.Rproj" "!project_name!.Rproj"

REM Change project name in .Renviron
(for /f "delims=" %%a in ('type "!project_directory!\.Renviron"') do (
    set "line=%%a"
    if "!line!"=="" (
        echo PROJECT_NAME = "!project_name!"
    ) else (
        echo !line!
    )
)) > "!project_directory!\.Renviron.tmp"
move /y "!project_directory!\.Renviron.tmp" "!project_directory!\.Renviron"

REM Change project name in README.md
(for /f "delims=" %%a in ('type "!project_directory!\README.md"') do (
    set "line=%%a"
    if "%%a"=="" (
        echo # !project_name!
    ) else (
        echo !line!
    )
)) > "!project_directory!\README.md.tmp"
move /y "!project_directory!\README.md.tmp" "!project_directory!\README.md"

REM Delete this script from the new folder
del /q "!project_directory!\CreateNewRProject.R"

echo Project setup complete!
echo New project created at !project_directory!
exit /b
