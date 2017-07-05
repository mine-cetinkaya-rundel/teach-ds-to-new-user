library(ggmap)

myLocation <- "Greensboro, North Carolina"
maptype1 = c("watercolor", "toner", "watercolor")
maptype2 = c("roadmap", "terrain", "satellite", "hybrid")
myMap <- get_map(location = myLocation,
                 source = "google", maptype = "roadmap", zoom = 7, crop = FALSE)

save(myMap, file = "myMap.Rdata")
