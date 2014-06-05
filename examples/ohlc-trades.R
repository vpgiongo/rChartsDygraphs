library(rChartsDygraphs); library(quantmod); require(data.table)
getSymbols("SPY", from = "1993-01-01")

dygraph(data=SPY, legendFollow=T, candlestick=T)
dygraph(data=SPY, legendFollow=T) #autodetects is.OHLC(data)

# trade annotations (arrows) example
trades= structure(list(Instrument = c("SPY", "SPY", "SPY", "SPY", "SPY"),
               TradeID = 741:745, 
               PL = c(0.01256257562457, -0.00773754987439038, -0.000192819186643255, 
                      -0.00797906187922958, -0.00776722232180197), 
               Base = c(1685.96, 1691.75, 1763.31, 1807.23, 1841.07), 
               Start = structure(c(15916, 15975, 16008, 16036, 16069), 
                                 class = c("IDate", "Date")), 
               End = structure(c(15922, 15981, 16014, 16043, 16076), 
                               class = c("IDate", "Date")), 
               Side = c(rep(c("Long", "Short"), each=2), "Long")), 
               class = c("data.table", "data.frame"), row.names = c(NA, -5L))

entries = trades[, list(Date=Start, Side=Side, E="Entry", Price=Base, PL=PL)]
exits = trades[, list(Date=End, Side=Side, E="Exit", Price=Base*(1+PL), PL=PL)]
ann = rbindlist(list(entries, exits))

ann[, canvas:="#!Dygraph.Circles.ARROW!#"]
ann[, rotation:=ifelse(Side=="Long", 
                       ifelse(E=="Entry", "up", "down"), 
                       ifelse(E=="Entry", "down", "up"))]
ann[, fillStyle:=ifelse(E=="Entry", "white", ifelse(PL>=0, "green", "red"))]
ann[, strokeStyle:="black"]
ann[, x:= paste0("#!Date.parse('", Date, "')!#")]
ann[, series:=1]
ann = ann[,c("series", "x", "canvas", "rotation","fillStyle", "strokeStyle"), with=F]

dy = dygraph(data=SPY[,"SPY.Close"], legendFollow=T)
dy$setOpts(annotations=toJSONArray(ann, json=F))
dy$setTemplate(script=system.file("/libraries/dygraph/layouts/annotations.html"
                                  , package = "rChartsDygraphs"))
dy

# file.path(getwd(), "inst/libraries/dygraph/layouts/annotations.html")
