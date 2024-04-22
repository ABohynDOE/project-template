@echo off

REM Run the R scripts sequentially
Rscript.exe R\import-tot.R
Rscript.exe R\create-progs.R
Rscript.exe R\create-report.R
Rscript.exe R\run-figures.R
Rscript.exe R\run-tables.R
Rscript.exe R\run-report.R

