library(rCharts)
options(RCHART_LIB = 'polycharts')

shinyUI(pageWithSidebar(
    headerPanel("Better Life Index: OECD Indicators"),

    sidebarPanel(width=3,

        selectInput(
            inputId = "indicator",
            label = "Select indicator",
            choices = sort(unique(ble$Indicator)),
            selected = 'Voter turnout'
        ),

        selectInput(
            inputId = "year",
            label = "Select year to compare countries",
            choices = sort(unique(ble$Year)),
            selected = 2013
        ),

        selectInput(
            inputId = "country",
            label = "Select country to compare years",
            choices = sort(unique(as.character(ble$Country))),
            selected = "Germany"
        ),

        selectInput(
            inputId = "inequality",
            label = "Contrast by Gender or Educational Attainment",
            choices = c('Gender', 'Educational Attainment'),
            selected = "Gender"
        ),

        strong('Data sources: '), uiOutput('info1'),
        strong('Data characteristics:'), uiOutput('info2'),
        strong('Unit of measure used:'), uiOutput('info3'),
        strong('Key statistical concept:'), uiOutput('info4')
    ),

    mainPanel(
        tabsetPanel(

            tabPanel('Plots',
                     uiOutput('title1'),
                     showOutput(outputId='chart1', lib='polycharts'),
                     uiOutput('title2'),
                     showOutput(outputId='chart2', lib='polycharts')
            ),

            tabPanel("About", includeMarkdown("README.md"))
        )
    )
))