# Statistical Data
## Visualizing Distributions
library(datasets)
library(tidyverse)

aq <- airquality %>%
  drop_na()

aqplot <- aq %>%
  ggplot(aes(x = Wind)) 

aqplot +
  geom_histogram()

aqplot +
  geom_histogram(bins = 10)

aqplot +
  geom_histogram(binwidth = 2)

aqplot +
  geom_density()

aq %>% 
  filter(Month == 6 | Month == 7) %>%
  ggplot(aes(Wind, fill = factor(Month))) + 
  geom_density(alpha = .5)

aq %>% 
  ggplot(aes(Wind, fill = factor(Month))) + 
  geom_density(alpha = .5)

## Multiple Distribution Comparisons
aqplot <- aq %>%
  ggplot(aes(x = factor(Month), y = Wind))

aqplot + 
  geom_point()

aqplot + 
  geom_jitter()

aqplot + 
  geom_boxplot()

aqplot + 
  geom_boxplot() + 
  geom_jitter()

aqplot + 
  geom_violin()

aqplot + 
  geom_violin() + 
  geom_jitter()

library(ggforce)

aqplot + 
  geom_sina() 

aqplot + 
  geom_violin() +
  geom_sina()

library(ggbeeswarm)

aqplot +
  geom_beeswarm()

aq %>% mutate(highOz = Ozone > mean(Ozone)) %>%
  ggplot(aes(x = factor(Month), y = Wind, color = highOz)) +
  geom_beeswarm()

aqTrans <- aq %>%
  pivot_longer(-c(Month, Day),
               names_to = "Measurement",
               values_to = "value")
head(aqTrans)

aqTrans %>% 
  ggplot(aes(Measurement, value)) +
  geom_beeswarm()

aqTrans %>% 
  ggplot(aes(Measurement, value)) +
  geom_violin() +
  geom_sina()

## Fine Detail Distribution
ggplot(aq, aes(sample = Temp)) + 
  geom_qq()

ggplot(aq, aes(sample = Temp)) +
  geom_qq() +
  geom_qq_line()

library(magrittr)
library(scales)

aq.qq <- aq %$%
  data.frame(wind = sort(Wind),
             ozone = sort(Ozone),
             solar = sort(Solar.R),
             temp = sort(Temp))

aq.qq %>% ggplot(aes(wind, solar)) + 
  geom_point()

aq.qq <- aq %$%
  data.frame(wind = sort(Wind),
             ozone = sort(Ozone),
             solar = sort(Solar.R),
             temp = rescale(Temp, to = c(0, 1)) %>% sort)

aq.qq %>% 
  mutate(wind = (wind - min(wind))/(max(wind) - min(wind))) %>%
  mutate(ozone = rescale(ozone, to = c(0, 1))) %>%
  ggplot(aes(wind, ozone)) + 
  geom_point() + 
  geom_abline(slope = 1, intercept = 0)

aq.qq %>% 
  ggplot(aes(rescale(wind, to = c(0, 1)), temp)) +
  geom_point() +
  geom_abline(slope = 1, intercept = 0)


# Axis Transformations
## Applying Log Transformation
library(gcookbook)  

stock <- aapl %>%
  mutate(logPrice = log(adj_price))

stock %>%
  ggplot(aes(date, adj_price)) +
  geom_line()

stock %>%
  ggplot(aes(date, logPrice)) +
  geom_line()

## Applying Log Scales
applePlot <- ggplot(aapl, aes(x = date, y = adj_price)) +
  geom_line()

applePlot + 
  scale_y_log10()

applePlot +
  scale_y_log10(breaks = 10^(-2:2),
                labels = trans_format("log10", math_format(10^.x)))

applePlot +
  scale_y_log10(breaks = 10^(-2:2),
                labels = trans_format("log10", math_format(.x))) +
  ylab("Log of Price")

applePlot +
  scale_y_log10(breaks = c(0.01, 0.25, 1, 20, 100, 250))

## Controlling Log Bases
library(scales)

applePlot + 
  scale_y_continuous(trans = "log2")

applePlot + 
  scale_y_continuous(
    trans = "log2",
    breaks = trans_breaks("log2", function(x) 2^x),
    labels = trans_format("log2", math_format(2^.x)) 
  ) 

applePlot +
  scale_y_continuous(
    trans = log_trans(),
    breaks = trans_breaks("log", function(x) exp(x)),
    labels = trans_format("log", math_format(e^.x))
  ) 

## Smoothing
applePlot + 
  geom_smooth()

applePlot + 
  geom_smooth(method = lm)

library(tidyquant)

applePlot + 
  geom_ma()

applePlot + 
  geom_ma(ma_fun = SMA, n = 100, size = 1, color = "red") +
  geom_ma(ma_fun = EMA, n = 50, size = 1, color = "blue")