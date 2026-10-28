# La Liga Match Outcome Classification

An academic data science project exploring Spanish La Liga match results using **R**, exploratory data analysis, and **Random Forest** classification.

## Project overview
- **Task:** classify match outcomes as home win (H), draw (D), or away win (A).
- **Source:** [Football-Data.co.uk](https://www.football-data.co.uk/), 2019–20 through 2023–24 seasons.
- **Approach reported:** download seasonal CSV files, clean data, explore match statistics, engineer team-form features, and train a Random Forest model.
- **Reported result:** 58.8% accuracy and Cohen's kappa 0.329 in the submitted course report. These numbers have **not** been independently reproduced in this repository.

## Important limitation
The original analysis includes same-match shots, shots on target, fouls, corners, and cards as predictors. These values are typically unknown **before kickoff**. This is therefore a **retrospective match-outcome classification study**, not a validated pre-match prediction system. A future pre-match model should use only information available before the match, and evaluate using chronological splits.

## Techniques
R · dplyr · ggplot2 · caret · randomForest · exploratory data analysis · classification

## Project status
This is an initial documentation import from an academic report. A report-based R script is available as [`analysis.R`](analysis.R), and an adapted report summary is in [`docs/report_summary.md`](docs/report_summary.md). 

## Reference
Project report: *Prediction of La Liga Match Outcomes Using Machine Learning Techniques* .
