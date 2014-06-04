library(rChartsDygraphs); library(quantmod)
getSymbols("SPY", from = "1993-01-01")
SPY <- data.frame(Date=index(SPY), Price=SPY$SPY.Close)
SPY$Momentum20days <- momentum(SPY$SPY.Close, 20)/lag(SPY$SPY.Close, 20)*100

dygraph1 <- dygraph(data=SPY[,c("Date","SPY.Close")], sync=TRUE, crosshair="vertical", legendFollow=TRUE, height = 400, width=1000)
dygraph2 <- dygraph(data=SPY[,c("Date","Momentum20days")], sync=TRUE, crosshair="vertical", legendFollow=TRUE, height = 200, width=1000, colors='grey')

layout_dygraphs(dygraph1, dygraph2)

#now let's hack away at a bootstrap grid solution
#eventually this should be easily afforded a user in a simple function
#or added to layout_dygraphs
#other libraries like xts and zoo layout without a matrix argument
dygraph1a <- dygraph1$copy()
dygraph1a$params$width <- NULL #let dygraphs fill width of containing div
dygraph1a$setTemplate(
  chartDiv = sprintf(
    "<div class = 'row'>
    %s
    ", gsub(
      x = dygraph1a$templates$chartDiv
      , pattern = "(\\{\\{ lib \\}\\})"
      , replacement = "\\1 col-md-6"  #this is a bootstrap responsive column
    )
  )
)
dygraph2a <- dygraph2$copy()
dygraph2a$params$width <- NULL  #let dygraphs fill width of containing div
dygraph2a$setTemplate(
  chartDiv = sprintf(
    "%s
    </div><!--row-->
    ", gsub(
      x = dygraph2a$templates$chartDiv
      , pattern = "(\\{\\{ lib \\}\\})"
      , replacement = "\\1 col-md-4"
    )
  )
)

layout_dygraphs_bootstrap(dygraph1a,dygraph2a)



#or as a slightly different example let's plot 3 dygraphs in a grid
dygraph1b <- dygraph1$copy()
dygraph1b$params$width <- NULL #let dygraphs fill width of containing div
dygraph1b$setTemplate(
  chartDiv = sprintf(
    "<div class = 'row'>
      <div class = 'col-sm-6'>
        %s
      </div><!-- col-sm-6 -->
    "
    , dygraph1b$templates$chartDiv
  )
)
dygraph2b <- dygraph2$copy()
dygraph2b$params$width <- NULL  #let dygraphs fill width of containing div
dygraph2b$setTemplate(
  chartDiv = sprintf(
    "<div class = 'col-sm-6'>
      <div class = 'row'>
        <div class = 'col-sm-12'>
    %s
        </div><!-- col-sm-12 -->
      </div><!--row-->
    ", gsub(
      x = dygraph2b$templates$chartDiv
      , pattern = "(\\{\\{ lib \\}\\})"
      , replacement = "\\1 col-sm-12"
    )
  )
)
#let's get another set of signal data to plot in a 3rd chart
SPY$RSI100days <- RSI(SPY$SPY.Close, 100)
dygraph3b <- dygraph(data=SPY[,c("Date","RSI100days")], sync=TRUE, crosshair="vertical", legendFollow=TRUE, height = 200, width=NULL, colors='purple')
dygraph3b$params$width <- NULL
dygraph3b$setTemplate(
  chartDiv = sprintf(
    "<div class = 'row'>
      <div class = 'col-sm-12'>
      %s
      </div><!-- col-sm-12 -->
     </div><!--row-->
    </div><!-- col-sm-6 -->
    </div><!-- row -->
    ", gsub(
      x = dygraph3b$templates$chartDiv
      , pattern = "(\\{\\{ lib \\}\\})"
      , replacement = "\\1 col-sm-12"
    )
  )
)

layout_dygraphs_bootstrap(dygraph1b,dygraph2b,dygraph3b)