## Installation

You can install `rCharts` from `github` using the `devtools` package

```r
require(devtools)
install_github("rCharts","timelyportfolio",ref="dimple_layer") # use this specific branch with temp fix
install_github('rChartsDygraphs', 'danielkrizian')
```

## Examples

```r
library(rChartsDygraphs); library(quantmod); require(data.table)
getSymbols("SPY", from = "2001-01-01")

# candlestick
dygraph(data=SPY, legendFollow=T, candlestick=T)
dygraph(data=SPY, legendFollow=T) #autodetects is.OHLC(data)

# trade annotations (arrows)
data(trades)
dygraph(data=SPY[,"SPY.Close"], legendFollow=TRUE, trades=trades)

# relative performance
getSymbols("IBM", from = "2001-01-01", adjust=T)
dygraph(merge(IBM[,"IBM.Adjusted"], SPY[,"SPY.Adjusted"]), rebase="percent")

# color ribbon (highlight special events)
dydata=SPY[,"SPY.Close"]
colors = rep("transparent", NROW(dydata)) # must equal NROW(data)
colors[1000:1550] = "lightgreen" # accepts "#90EE90" representation too
colors[1700:2050] = "red"
colors[2060:2140] = "lightblue"
dygraph(data=dydata, ribbon=colors)
dygraph(data=dydata, ribbon=list(colors=ribbon, height=0.2, pos=0.1))
```

View interactive charts [like this (link)](http://rawgit.com/danielkrizian/rChartsDygraphs/master/examples/multi-layout.html)

Zoom: mouse left-click & drag; Pan: Shift + mouse left-click & drag

<iframe src="http://rawgit.com/danielkrizian/rCharts_dygraphs/master/examples/multi-layout.html" style="width: 1200px; height: 900px;"/iframe>

