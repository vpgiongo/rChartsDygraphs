require(rChartsDygraphs)
getSymbols("SPY", from = "2001-01-01")
difference = SPY[,"SPY.Open"]-SPY[,"SPY.Close"]
decreasing = which(difference<0)
increasing = which(difference>0)

colors = rep("transparent", nrow(dydata))
colors[decreasing] = "red"
colors[increasing] = "green"

dydata=SPY[,"SPY.Close"]
dygraph(data=dydata, ribbon=list(colors=colors, height=0.05, pos=0.02))
