# Load packages -----------------------------------------------------

library(rvest)
library(stringr)
library(dplyr)

# Read page with season data ----------------------------------------

page <- read_html("http://goduke.statsgeek.com/basketball-m/seasons/schedule.php?season=2014-15")

# Harvest fields ---------------------------------------------------- 

date <- page %>%
  html_nodes(".stattextline b") %>%
  html_text()

opponent <- page %>%
  html_nodes(".stattextltgray2:nth-child(3)") %>%
  html_text() %>%
  str_trim()

venue <- page %>%
  html_nodes(".stattextltgray2:nth-child(5)") %>%
  html_text() %>%
  str_trim()

# Put fields into a tibble ------------------------------------------

blue_devils_1415 <- tibble(date, opponent, venue)