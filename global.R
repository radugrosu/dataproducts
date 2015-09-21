library(dplyr)
library(rCharts)
library(ggplot2)
library(rjson)

# Read in the three available datasets
# http://stats.oecd.org/Index.aspx?DataSetCode=BLI
ble_2013 = read.csv("data/BLI2013_18092015172225789.csv", as.is=TRUE)
ble_2014 = read.csv("data/BLI2014_18092015172200914.csv", as.is=TRUE)
ble_2015 = read.csv("data/BLI2015_18092015172054680.csv", as.is=TRUE)

# add 'Year' field to each dataset
ble_2013$Year = 2013
ble_2014$Year = 2014
ble_2015$Year = 2015

# add 'Unit' field to the 2013 dataset
ble_2013$Unit = ble_2013$Indicator %>%
    sapply(function(x) ble_2014$Unit[match(x, ble_2014$Indicator)])

# select only the fields of interest
fields = c('LOCATION', 'Country', 'Indicator', 'Inequality',
           'Unit', 'Value', 'Year')

ble_2013 = ble_2013 %>% subset(select=fields)
ble_2014 = ble_2014 %>% subset(select=fields)
ble_2015 = ble_2015 %>% subset(select=fields)

# consolidate into a single dataset
ble = rbind(ble_2013, ble_2014, ble_2015)
ble = rename(ble, Country_Code = LOCATION)

ch1 = sort(unique(filter(ble, Inequality=="High")$Indicator))
ch2 = sort(unique(ble$Indicator))

info = fromJSON(file='info/info.json')

tooltip_formatter="!#function(item){return item.Year}#!"


# sadly not working, along with the tooltip formatter and various other broken
# functionality related to Shiny and rCharts
after_script = "
  <script>
   graph_chart2.addHandler(function(type, e){
      var data = e.evtData
      if (type === 'click'){
        alert('Year: ' + data.Year.in[0] + '\\n' +
              'Value: ' + data.Value.in[0] + ' ' + '(' + data.Unit.in[0] + ')')
      }
   })
  </script>
"
