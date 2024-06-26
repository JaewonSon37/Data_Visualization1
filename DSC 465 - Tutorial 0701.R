# Categorical Data – Mosaic Plots
haireye<-matrix(data = c(20, 5, 15, 68, 84, 29, 54, 119, 17, 14, 14, 26, 94, 16, 10, 7),
                nrow = 4,ncol = 4,byrow = TRUE,
                dimnames = list(c("Black", "Brunette", "Red", "Blond"),
                                c("Blue", "Green", "Hazel", "Brown")))
head(haireye)

mosaicplot(t(haireye), main=" ", las = 1, cex = 0.75, color = TRUE)