# La Liga Match Outcome Classification — Portfolio Report

**Name: Tousif Anam**

*Adapted portfolio summary based on the submitted academic group-project report. The original PDF is unchanged and its original contributors are not being reattributed.*

## Objective
Classify La Liga match outcomes as Home Win (H), Draw (D), or Away Win (A), and analyze associations between match statistics and results.

## Data and tools
- **Source:** [Football-Data.co.uk](https://www.football-data.co.uk/)
- **Seasons:** 2019–20 through 2023–24
- **Dataset:** approximately 1,900 matches
- **Tools:** R, dplyr, ggplot2, caret, randomForest
- **Features:** team names, shots, shots on target, fouls, corners, yellow/red cards and historical win counts.

## Method
Season CSV collection, data cleaning, EDA, lagged cumulative home/away win features, stratified 80/20 train/test split, and a 200-tree Random Forest classifier.

## Results reported in the original document
| Metric | Value |
|---|---:|
| Accuracy | 58.8% |
| No-information rate | 44.6% |
| Cohen's kappa | 0.329 |

These reported figures are **not independently reproduced** by the reconstructed script.

## Main findings
Home wins were more common than away wins or draws. Match attacking statistics were associated with results. Draw classification was comparatively weak.

## Limitations
Shots, fouls, corners and cards are observed **during or after the match**. Consequently, this is a retrospective classification project, **not validated pre-match forecasting**. Future work should build pre-kickoff features, perform chronological validation, and assess macro-F1 and class-wise recall.

## Code status
The included `analysis.R` is reconstructed from the supplied course report and should not be confused with an independently verified original source file.
