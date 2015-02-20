library(shiny)

# Define UI for application that draws a histogram
shinyUI(
        #        fluidPage(
        navbarPage("Kepler light curves visualization",       
                   # Sidebar with a slider input for the number of bins
                   tabPanel("Plotting data",
                            sidebarPanel(
                                    uiOutput("lightCurves"),
                                    radioButtons('DotColor', 'Dot color',
                                                 c('Black'='Black','Gray'='Gray','White' = 'White'),inline = TRUE),
                                    radioButtons('TranColor', 'Transit color',
                                                 c('Orange'='Orange','Teal' = 'DarkCyan','Black' = 'Black'), inline = TRUE),
                                    radioButtons('View', 'View',
                                                 c('Regular'='0','Zoomed'='1'), inline = TRUE),
                                    uiOutput("quarterSel"),
                                    actionButton(inputId = "clear_all", label = "Clear selection", 
                                                 icon = icon("check-square")),
                                    actionButton(inputId = "select_all", label = "Select all", 
                                                 icon = icon("check-square-o"))
                            ),
                            
                            # Show a plot of the generated distribution
                            mainPanel(
                                    tabsetPanel(type = "pills", 
                                                tabPanel("Full Plot", 
                                                         uiOutput("daysSel"),
                                                         checkboxInput('Fitting','Fitting curve',value = TRUE),
                                                         plotOutput("FullPlot")
                                                ), 
                                                tabPanel("Split Plot", plotOutput("SplitPlot")) 
                                    )
                            )
                   ),
                   tabPanel("About",
                            mainPanel(
                                    includeMarkdown("Kepler.md")
                            )
                   )
        )
)


# runExample("06_tabsets")