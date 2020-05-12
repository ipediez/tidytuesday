library(plotly)
library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(tidyr)

videogames <- read.csv("../data/metacritic_games.csv")

# Platform / Genre
genres <- table(videogames$genre)

keep <- names(genres[which(genres > 200)])
videogames <- videogames %>% filter(genre %in% keep)

fig <- videogames %>% count(platform, genre)
fig <- fig %>% plot_ly() %>% 
  add_trace (x= ~platform, y= ~n, color = ~genre,
             colors = brewer.pal(8, "PRGn"), 
             type = "bar")

fig <- fig %>% layout(
  title = "Videojuegos publicados por plataforma y género", 
  xaxis = list(title="Plataformas"),
  yaxis = list(title="Número de videojuegos")
)

fig
# Month of the year

videogames <- separate(videogames,
                       col = "release_date",
                       into = c("month_day", "year"),
                       sep = ", ")


fig <- plot_ly(
  x = table(videogames$year),
  y = names(table(videogames$year)),
  type = "bar",
  color = I("#A6DBA0")
)

fig <- fig %>% layout(
  title = "Videojuegos publicados por año",
  xaxis = list(title="Número de videojuegos"),
  yaxis = list(title="Año de publicación")
)

fig
