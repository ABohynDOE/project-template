#!/bin/bash

# Run the R scripts sequentially
Rscript "R/import-tot.R"
Rscript "R/create-progs.R"
Rscript "R/create-report.R"
Rscript "R/run-figures.R"
Rscript "R/run-tables.R"
Rscript "R/run-report.R"
