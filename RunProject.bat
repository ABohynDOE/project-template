@echo off

REM Run the R scripts sequentially
"C:\Program Files\R\R-4.3.1\bin\x64\Rscript.exe" R\import-tot.R
"C:\Program Files\R\R-4.3.1\bin\x64\Rscript.exe" R\create-progs.R
"C:\Program Files\R\R-4.3.1\bin\x64\Rscript.exe" R\create-report.R
"C:\Program Files\R\R-4.3.1\bin\x64\Rscript.exe" R\run-figures.R
"C:\Program Files\R\R-4.3.1\bin\x64\Rscript.exe" R\run-tables.R
"C:\Program Files\R\R-4.3.1\bin\x64\Rscript.exe" R\run-report.R

pause