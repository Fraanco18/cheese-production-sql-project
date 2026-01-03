# Processed Data

This folder contains the **cleaned and analytics-ready dataset** used for all analysis and visualizations in this project.

## Source Tables

The processed dataset was created by combining and transforming data from:

- `cheese_production` (primary production data)
- `state_lookup` (state code to state name mapping)

## Description

Using SQL, the raw tables were cleaned, validated, and joined to produce a single consolidated dataset suitable for analysis.

Key processing steps include:

- Data type normalization and numeric value cleaning
- Resolution of mixed time granularity (annual vs monthly records)
- Removal of duplicate production values
- Handling of missing or invalid `state_ANSI` codes
- Enrichment of production records with full state names via `state_lookup`
- Post-creation validation checks to ensure aggregate consistency

## Purpose

This dataset is optimized for:

- Trend analysis over time
- Geographic comparison across U.S. states
- Multi-year period comparisons
- Visualization in Tableau

## Usage

- This is the **only dataset** used in the Tableau dashboard.
- All transformations are fully reproducible using the SQL script located in:
  `/sql/cheese_cleaning.sql`

## Disclaimer

Known data limitations and methodological considerations are documented in the **Data Limitations** section of the main project README.

