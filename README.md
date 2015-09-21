---
title: "Better Life Index. A visualization based on OECD data"
output:
    html_document:
        theme: flatly
---

## Motivation
This presentation was created as part of the course project for the **Developing Data Products** class within the **Coursera** *Data Science specialization track*.

It is supposed to showcase the possibilities offered by RStudio's [Shiny](http://www.shinyapps.io/) web-app building platform and the extra interactivity offered by the [rCharts](http://rcharts.io/) package.

## The Data

The datasets ^[1](http://stats.oecd.org/Index.aspx?DataSetCode=BLI) used for this visualisation is provided by the [Organization for Economic Co-Operation and Development](oecd.org) as a part of its [Better Life Initiative](http://www.oecd.org/statistics/better-life-initiative.htm). This effort allows the OECD to better advise policy makers on the priorities they should concentrate on to deliver better lives for their citizens. 

The data mostly come from official sources such as the OECD or National Accounts, United Nations Statistics, National Statistics Offices. A couple of indicators are based on data from the Gallup World Poll a division of the Gallup Organization that regularly conducts public opinion polls in more than 140 countries around the world.


>The OECD Better Life Initiative focuses on developing statistics to capture aspects of life that matter
to people and that shape the quality of their lives. This allows for a better understanding of what
drives the well-being of people and nations, and what needs to be done to achieve greater progress
for all.

>The Better Life Index aims to involve citizens in the debate on measuring the well-being of societies, and to empower them to become more informed and engaged in the policy-making process that shapes all our lives.
Each of the 11 topics (community, education, environment, civic engagement, health, housing, income, jobs, life satisfaction, safety and work-life balance) of the Index is currently based on one to three indicators. Within each topic, the indicators are averaged with equal weights. The indicators have been chosen on the basis of a number of statistical criteria such as relevance (face-validity, depth, policy relevance) and data quality (predictive validity, coverage, timeliness, cross-country comparability etc.) and in consultation with OECD member countries. These indicators are good measures of the concepts of well-being, in particular in the context of a country comparative exercise. Other indicators will gradually be added to each topic.

The OECD provides a dataset with measurements for 24 indicators for each year starting with 2013.
These datasets were downloaded manually, and then cleaned and consolidated in **R**.

The large majority of these indicators is gender-specific, i.e. available for women and men separately. In a small minority of cases (e.g. in the housing dimension), the indicators cannot be broken down by gender and thus the average country value are supplied for both women and men. 
    Similarly, majority of indicators is available separately for high socio-economic status versus low socio-economic status. In the case of education, high socio-economic status is defined as the group of the population with a tertiary education degree while low socio-economic status is defined as the group of the population with a primary education degree.


## The Visualization

For any chosen indicator the first plot displays its measure across countries for the chosen year, and the second plot diplays its measure for the selected country across the years 2013-2015.
One of two contrasts can be chosen for both plots: differences due to Gender, and differences due to Socio-economic status (Educational attainment `ISCED 5/6` group vs. `ISCED 0/1/2` group^[2](http://www.uis.unesco.org/Education/Documents/isced-2011-en.pdf) ).


## Source

The source files for this visualization are available on [GitHub](https://github.com/radugrosu/dataproducts).


----
*Acknowledgements*:  This visualization was inpired by [this](http://ramnathv.github.io/rChartsShiny/) post.