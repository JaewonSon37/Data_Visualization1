# High Dimensional Data
## Parallel Coordinates
library(GGally)

ggparcoord(iris)

ggparcoord(iris,
           columns = 1:4,
           groupColumn = 'Species',
           order = c(2, 1, 3, 4),
           showPoints = TRUE,
           title = 'Parallel Coordinate Plot for the Iris Data',
           alphaLines = 0.3) + 
  scale_color_viridis_d() +
  theme(plot.title = element_text(size = 10))

## Star Plot
stars(mtcars)

stars(mtcars,
      draw.segments = TRUE)

stars(mtcars[, 1:7],
      draw.segments = TRUE,
      len = 0.8,
      key.loc = c(12, 2),
      main = 'Moter Trend Cars',
      full = FALSE,
      labels = abbreviate((case.names(mtcars))))


# Multidimensional Scaling (MDS)
carsdists <- mtcars %>%
  scale %>%
  dist
head(carsdists)

mds <- data.frame(cmdscale(carsdists))

ggplot(mds, aes(X1, X2)) + 
  geom_point()

library(dplyr)

carsWMDS <- inner_join(mtcars %>%
                         mutate(name = rownames(.)) %>%
                         mutate(idx = 1:n()),
                       mds %>% 
                         mutate(idx = 1:n()) )
head(carsWMDS)

ggplot(carsWMDS, aes(X1, X2)) +
  geom_point() +
  geom_label(aes(label = name))


# Graphs
library(igraph)

graphdata <- graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6))
graphdata

plot(graphdata)

graphdata <- graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6), directed = FALSE)
plot(graphdata, vertex.label = NA)

library(gcookbook)

head(madmen2)

g <- graph.data.frame(madmen2, directed = TRUE)
g

plot(g,
     layout = layout.fruchterman.reingold)

plot(g, 
     layout = layout.fruchterman.reingold,
     vertex.size = 8,
     edge.arrow.size = 0.5,
     vertex.label = NA)  

g <- graph.data.frame(madmen, directed = FALSE)
g

plot(g,
     layout = layout.circle)

plot(g, 
     layout = layout.circle,
     vertex.size = 8,
     vertex.label = NA)


# Text
library(ggwordcloud)

data("love_words_small")
data("love_words")

set.seed(42)
ggplot(love_words_small, aes(label = word, size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 20) +
  theme_minimal()

set.seed(42)
ggplot(love_words_small, aes(label = word, size = speakers)) +
  geom_text_wordcloud() +
  scale_radius(range = c(0, 20), limits = c(0, NA)) +
  theme_minimal()