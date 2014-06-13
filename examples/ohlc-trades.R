library(rChartsDygraphs); library(quantmod); require(data.table)
getSymbols("SPY", from = "2001-01-01")

# candlestick
dygraph(data=SPY, legendFollow=T, candlestick=T)
dygraph(data=SPY, legendFollow=T) #autodetects is.OHLC(data)

# trade annotations (arrows)
data(trades)
dygraph(data=SPY[,"SPY.Close"], legendFollow=TRUE, trades=trades)

# trade annotations (arrows)
getSymbols("IBM", from = "2001-01-01", adjust=T)

# relative performance
dygraph(merge(IBM[,"IBM.Adjusted"], SPY[,"SPY.Adjusted"]), rebase="percent")
