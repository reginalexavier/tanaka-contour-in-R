#libraries used
library(tanaka)
library(raster)
library(sf)
library(cartography)

#loading the geographics files
mask_file <- sf::st_read("rawdata/shapes/haiti_shape.shp")

raster_file <- raster::raster("rawdata/rasters/haiti_srtm_wgs_18N.tif")

resample_raster <- raster::aggregate(raster_file, fact = 50, fun = mean) #resampling the raster file


png("output/plots/haiti_TanakaContour_50.png", #creating the map file
  width = 1200,
  height = 850,
  pointsize = 6,
  res = 300
) 
par(mar = c(0, 0, 1, 0)) #setting the margin

#tanaka contour
tanaka::tanaka(
  resample_raster,
  breaks = c(seq(0, 2500, 250), 2680),
  legend.pos = "n",
  legend.title = "Elevation\n(meters)",
  col = carto.pal("harmo.pal", length(c(
    seq(0, 2500, 250), 2680
  ))),
  light = "#ffffff70",
  dark = "#00000090",
  mask = mask_file
)
#legend configuration
cartography::legendChoro(
  pos = "topleft",
  title.txt = "Élévation\n(mètres)",
  title.cex = 1,
  breaks = c(seq(0, 2500, 250), 2680),
  col = carto.pal("harmo.pal", length(c(
    seq(0, 2500, 250), 2680
  ))),
  nodata = FALSE,
  nodata.txt = "No Data",
  frame = F
)
#layout part
cartography::layoutLayer(
  title = "\n\nHaiti (Tanaka Contours)",
  tabtitle = TRUE,
  frame = TRUE,
  horiz = TRUE,
  col = "black",
  author = "@TRedgi, 2019",
  sources = "Sources: NASA SRTM Version 3.0",
  north = TRUE,
  theme = NULL,
  extent = NULL,
  scale = 50
)

dev.off()