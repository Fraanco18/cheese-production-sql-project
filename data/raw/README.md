# Raw Data

This folder contains the **original, unmodified datasets** used in this project.

## Source Tables

The analysis is based on two raw tables:

### 1. cheese_production
Contains historical U.S. cheese production records, including:
- production volume values
- time information (year and, from 1990 onward, monthly records)
- state identifiers (`state_ANSI`)

This table includes known data quality issues such as:
- mixed time granularity (annual vs monthly records)
- formatting inconsistencies in numeric values
- missing or unassigned state identifiers

### 2. state_lookup
A reference table used to map `state_ANSI` codes to full U.S. state names.

This table does not contain production data and is used exclusively for data enrichment.

## Purpose

The raw datasets are preserved to:

- Ensure transparency and reproducibility
- Allow verification of the full data cleaning and enrichment process
- Serve as the baseline for all SQL transformations

## Notes

- No transformations, filters, or joins have been applied at this stage.
- These files should not be used directly for analysis or visualization.
- All cleaning, validation, and joins are performed in the SQL pipeline.

➡️ Refer to the `/sql` folder for the complete data preparation logic.


