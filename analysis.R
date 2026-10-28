# La Liga Match Outcome Classification
# R implementation reconstructed from project report by Tousif Anam.
# This script has not been executed or verified against the reported results.
# Uses same-match features: retrospective classification, NOT pre-match forecasting.
# install.packages(c("dplyr", "ggplot2", "caret", "randomForest"))
library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)

seasons <- c("2324", "2223", "2122", "2021", "1920")
all_data <- bind_rows(lapply(seasons, function(s) {
  df <- read.csv(paste0("https://www.football-data.co.uk/mmz4281/", s, "/SP1.csv"))
  df$Season <- s
  df
}))

matches <- all_data %>%
  select(Season, Date, HomeTeam, AwayTeam, FTHG, FTAG, FTR,
         HS, AS, HST, AST, HF, AF, HC, AC, HY, AY, HR, AR) %>%
  rename(HomeGoals = FTHG, AwayGoals = FTAG, Result = FTR,
         HomeShots = HS, AwayShots = AS, HomeShotsTarget = HST,
         AwayShotsTarget = AST, HomeFouls = HF, AwayFouls = AF,
         HomeCorners = HC, AwayCorners = AC, HomeYellowCards = HY,
         AwayYellowCards = AY, HomeRedCards = HR, AwayRedCards = AR) %>%
  na.omit()
matches$Date <- as.Date(matches$Date, format = "%d/%m/%Y")
if (anyNA(matches$Date)) stop("Check date formats in source CSV files")

matches <- matches %>% arrange(Season, Date) %>%
  group_by(Season, HomeTeam) %>%
  mutate(HomeForm = lag(cumsum(Result == "H"), default = 0)) %>%
  ungroup() %>% group_by(Season, AwayTeam) %>%
  mutate(AwayForm = lag(cumsum(Result == "A"), default = 0)) %>%
  ungroup()

print(table(matches$Result))
print(ggplot(matches, aes(x = Result, y = HomeShots)) +
        geom_violin() + geom_boxplot(width = 0.1) +
        labs(title = "Home Shots by Match Result"))

model_data <- matches %>%
  select(Season, HomeTeam, AwayTeam, HomeShots, AwayShots,
         HomeShotsTarget, AwayShotsTarget, HomeFouls, AwayFouls,
         HomeCorners, AwayCorners, HomeYellowCards, AwayYellowCards,
         HomeRedCards, AwayRedCards, HomeForm, AwayForm, Result) %>%
  mutate(across(c(Season, HomeTeam, AwayTeam, Result), as.factor))
set.seed(123)
train_idx <- createDataPartition(model_data$Result, p = 0.8, list = FALSE)
train_data <- model_data[train_idx, ]
test_data <- model_data[-train_idx, ]
rf_model <- randomForest(Result ~ ., data = train_data, ntree = 200,
                         importance = TRUE, classwt = c(A = 1, D = 2, H = 1))
predictions <- predict(rf_model, test_data)
print(confusionMatrix(predictions, test_data$Result))
print(importance(rf_model))
# Next: build pre-match-only features and use chronological evaluation.
