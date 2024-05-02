# Project-template

## Project description 

Fill in description of the project

## Project structure

The project has the following structure:

```
├── R/
│   ├── analysis/
│   ├── data-import/
│   ├── figures/
│   ├── reports/
│   ├── tables/
│   ├── create-progs.R
│   ├── create-report.R
│   ├── import-tot.R
│   ├── run-figures.R
│   ├── run-report.R
│   └── run-tables.R
├── Rdata/
│   ├── figures/
│   └── tables/
├── data/
│   ├── R/
│   ├── SAS/
│   ├── csv/
│   └── tot/
│       └── table-of-tables.xlsx
├── docs/
│   ├── literature/
│   ├── meetings/
│   └── sap/
│       └── sap.docx
├── raw-data/
├── results/
│   ├── figures/
│   ├── reports/
│   └── tables/
├── templates/
│   ├── template-figure.R
│   ├── template-report-figure.Rmd
│   ├── template-report-table.Rmd
│   ├── template-report.Rmd
│   ├── template-table.R
│   └── template.docx
├── README.md
├── RunProject.bat
├── RunProject.sh
└── project-template.Rproj
```

It contains 7 main folders:
- **docs**: contains all project related documents (meeting notes, SAP, literature, ...)
- **raw-data**: contains all raw data files (as provided by the client and untouched)
- **data**: contains all data files in `rds` format, generated from the `raw-data/` fodler
- **R**: contains all R scripts used to import the data, run the analysis or generate tables, figures and reports
- **Rdata**: contains all tables and figures previously generated, stored as `rds` files 
- **results**: contains all figures and tables previoulsy generated, as well as the global report, stored as `docx` or `pdf` files for the tables, and as `png` files for the figures
- **templates**: contains template for R scripts to generate figures and tables, as well as for the global report. Also contains the docx file that serves as template for the final report
