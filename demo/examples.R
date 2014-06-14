library(quantmod); require(data.table)
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
dygraph(data=dydata, ribbon=list(colors=colors, height=0.2, pos=0.1))


# millisecond
npoints<-500
Data_xts=xts(1:npoints, as.POSIXlt(1366039619, tz="GMT", origin="1970-01-01") + round(runif(npoints,1,50)))
names(Data_xts)<-'RandomData'
DataDF=data.frame(Date=index(Data_xts),coredata(Data_xts$RandomData))
DataDF$Date=paste("#!", as.numeric(strptime((DataDF$Date), format="%Y-%m-%d %H:%M:%OS"))*1000, "!#")

myChart = dygraph(DataDF)
myChart$setOpts(axes=list(
  x=list(
    ticker="#! Dygraph.dateTicker !#",
    axisLabelFormatter = "#! function (d, gran) {
                              return Dygraph.zeropad(d.getHours()) + ':' + 
                                     Dygraph.zeropad(d.getMinutes()) + ':' + 
                                     Dygraph.zeropad(d.getSeconds()) + '.' + 
                                     Dygraph.zeropad(d.getMilliseconds());
                             } !#",
    valueFormatter = "#! function (ms) {
                          var d = new Date(ms);
                          return Dygraph.zeropad(d.getHours()) + ':' + 
                          Dygraph.zeropad(d.getMinutes()) + ':' + 
                          Dygraph.zeropad(d.getSeconds()) + '.' + 
                          Dygraph.zeropad(d.getMilliseconds());
                         } !#"
    )
  )
)

myChart
