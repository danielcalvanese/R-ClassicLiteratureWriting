# Imports.
library(readr)
library(dplyr)
library(stringr)
library(tidyr)
library(ggplot2)
library(testthat)

# Open files.
titles <- read_csv('data/titles.csv')
stats <- read_csv('data/stats.csv')
published <- read_csv('data/published.csv')

# Join the title and stats data frames.
books <- full_join(titles, stats)

# Create a data frame that only has books authored by Dickens and select for certain columns.
dickens <- filter(books, str_detect(author, 'Dickens'))
dickens_stats <- select(dickens, id, words, sentences, to_be_verbs, contractions, pauses, cliches, similes)

# Join the dickens & published books data frames & reshape it.
time <- full_join(dickens_stats, published)
time_long <- gather(time, type, value, words:similes)

# Construct a plot.
p <- ggplot(time_long , aes(year, value, color = type)) + geom_line()

# Show the plot.
plot(p)