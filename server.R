library(dplyr)
library(rCharts)
options(
    RCHART_WIDTH = 800,
    rstudio.markdownToHTML =
        function(inputFile, outputFile) {
            require(markdown)
            markdownToHTML(inputFile, outputFile, stylesheet='www/bootstrap.css')
        }
)

shinyServer(function(input, output, session) {

    observe({
        choices = if (input$inequality != 'Gender') ch1 else ch2
        updateSelectInput(session=session,
                          inputId="indicator",
                          choices=choices,
                          selected='Voter turnout'
        )
    })

    output$chart1 = renderChart({
        YEAR = input$year
        INEQ = input$inequality
        IND  = input$indicator

        DATA = if (INEQ=='Gender') {
            list(filter(ble, Inequality=='Women', Year==YEAR, Indicator==IND),
                 filter(ble, Inequality=='Men',   Year==YEAR, Indicator==IND))
        } else {
            list(filter(ble, Inequality=='Low',   Year==YEAR, Indicator==IND),
                 filter(ble, Inequality=='High',  Year==YEAR, Indicator==IND))
        }

        p1 = rPlot(x = list(var = "Country_Code", sort = "Value"), y = "Value",
                   color = 'Inequality', data = DATA[[1]], type = 'bar')
        p1$layer(x='Country_Code', y='Value', color='Inequality',
                 type='point', size=list(const=4), shape=list(const="\u2642"),
                 data=DATA[[2]])
        p1$addParams(width = 1200, dom = 'chart1')
        p1$guides(x = list(title = "", ticks = unique(DATA[[2]]$Country_Code)),
                  y = list(max=1.2*max(DATA[[2]]$Value), title = ""))
        return(p1)
    })

    output$chart2 = renderChart({
        COUNTRY = input$country
        INEQ = input$inequality
        IND = input$indicator

        DATA = if (INEQ=='Gender') {
            list(filter(ble, Inequality=='Women', Country==COUNTRY, Indicator==IND),
                 filter(ble, Inequality=='Men',   Country==COUNTRY, Indicator==IND))
        } else {
            list(filter(ble, Inequality=='Low',   Country==COUNTRY, Indicator==IND),
                 filter(ble, Inequality=='High',  Country==COUNTRY, Indicator==IND))
        }

        p2 = rPlot(Value ~ Year, color='Inequality', type = 'line', data = DATA[[1]])
        p2$layer(Value ~ Year, color='Inequality', type = 'point',  data = DATA[[1]],
                 size=list(const=5), opacity=list(const=0.5))
        p2$layer(Value ~ Year, color='Inequality', type = 'line',   data = DATA[[2]])
        p2$layer(Value ~ Year, color='Inequality', type = 'point',  data = DATA[[2]],
                 size=list(const=3))
        p2$addParams(width = 1200, dom = 'chart2')
        p2$guides(x = list(min=2012.9, max=2015.1, labels=c(2013, 2014, 2015),
                           title = '',
                           formatter = "#!function(d){ return parseInt(d) }!#"))
        p2$guides(y = list(min = 0, max=max(DATA[[2]]$Value)*1.2, title = ''))
        p2$setTemplate(afterScript = after_script)
        return(p2)
    })

    output$title1 = renderUI({
        h3(paste(input$indicator, ' by country for ', input$year, sep=""), align='center')

    })

    output$title2 = renderUI({
        h3(paste(input$indicator, ' for ', input$country,' by Year', sep=""), align='center')

    })

    output$info1 = renderUI({helpText(info[[input$indicator]]$`Data sources`)})
    output$info2 = renderUI({helpText(info[[input$indicator]]$`Data Characteristics`)})
    output$info3 = renderUI({helpText(info[[input$indicator]]$`Unit of measure used`)})
    output$info4 = renderUI({helpText(info[[input$indicator]]$`Key statistical concept`)})
})