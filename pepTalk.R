# PEP TALK GENERATOR----
# Libraries----
pacman::p_load(tidyverse, magrittr, lubridate)

# # Sayings come from here: https://theraccoonsociety.com/products/pep-talk-generator-print
# # Read in data for the first time from the csv file that was downloaded from a Google Sheet
# df <- read_csv('/Users/rnguymon/Downloads/Pep Talk Generator - Sheet1.csv')
# df <- df[4:21,]
# names(df) <- c('p1', 'p2', 'p3', 'p4')
# paste(df$p4, collapse = '", "') %>% paste0('"',.,'"') %>% cat()
# Hard code the parts----
p1 <- c("Champ,", "Fact:", "Everybody says", "Dang...", "Check it:", "Just saying...", "Superstar,", "Tiger,", "Self,", "Know this:", "News alert:", "Girl,", "Ace,", "Excuse me but", "Experts agree:", "In my opinion,", "Hear ye, hear ye:", "Okay, listen up:")
p2 <- c("the mere idea of you", "your soul", "your hair today", "everything you do", "your personal style", "every thought you have", "that sparkle in your eye", "your presence here", "what you got going on", "the essential you", "your life's journey", "that saucy personality", "your DNA", "that brain of yours", "your choice of attire", "the way you roll", "whatever your secret is", "all of y'all")
p3 <- c("has serious game", "rains magic,", "deserves the Nobel Prize,", "raises the roof,", "breeds miracles,", "is paying off big time,", "shows mad skills,", "just shimmers,", "is a national treasure,", "gets the party hopping,", "is the next big thing,", "roars like a lion,", "is a rainbow factory,", "is made of diamonds,", "makes birds sing,", "should be taught in school,", "makes my world go 'round,", "is 100% legit,")
p4 <- c("24/7.", "can I get an amen?", "and that's a fact.", "so treat yourself.", "you feel me?", "that's just science.", "would I lie?", "for reals.", "mic drop.", "you hidden gem.", "snuggle bear.", "period.", "can you dig it?", "now let's dance.", "high five.", "say it again!", "according to CNN.", "so get used to it.")
df <- data.frame(p1 = p1
                 , p2 = p2
                 , p3 = p3
                 , p4 = p4)
# Randomly put them together----
saying <- c()
for(i in 1:4){
  ts <- sample(df[,i], 1)
  saying <- paste(saying, ts, sep = ' ')
}
saying <- trimws(saying, which = 'both')
saying
