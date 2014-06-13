## Installation

You can install `rCharts` from `github` using the `devtools` package

```r
require(devtools)
install_github("rCharts","timelyportfolio",ref="dimple_layer") # use this specific branch with temp fix
install_github('rChartsDygraphs', 'danielkrizian')
```

## Example 

```r
library(rChartsDygraphs); library(quantmod); require(data.table)
getSymbols("SPY", from = "2001-01-01")

# candlestick
dygraph(data=SPY, legendFollow=T, candlestick=T)

# trade annotations (arrows)
data(trades)
dygraph(data=SPY[,"SPY.Close"], legendFollow=TRUE, trades=trades)

# trade annotations (arrows)
getSymbols("IBM", from = "2001-01-01", adjust=T)

# relative performance
dygraph(merge(IBM[,"IBM.Adjusted"], SPY[,"SPY.Adjusted"]), rebase="percent")
```

View interactive charts [like this (link)](http://rawgit.com/danielkrizian/rChartsDygraphs/master/examples/multi-layout.html)

Zoom: mouse left-click & drag; Pan: Shift + mouse left-click & drag

<iframe src="http://rawgit.com/danielkrizian/rCharts_dygraphs/master/examples/multi-layout.html" style="width: 1200px; height: 900px;"/iframe>

