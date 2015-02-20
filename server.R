#library(shiny)
#source("StarDataCleaning.R")
source("PlottingFunctionsGGPlot.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        #       General reactive values
        values <- reactiveValues()
        #       Kepler curves management
        curves <- reactive({
                fileNames <- dir(pattern = "*.RDS")
                values$fileNames <- fileNames
                values$fileDesc <- gsub("\\..*","",values$fileNames)
                fileNames
        })
        output$lightCurves <- renderUI({
                radioButtons('lightCurves','Kepler Light Curves', curves(), curves()[1])       
        })
        
        #       Kepler selected curve data load
        kpl <- reactive({
                selFile <- input$lightCurves
                if(is.null(selFile))
                        return(NULL)
                kplx <- readRDS(selFile)
                kplxt <- ldply(kplx, .fun = NULL)
                
                quarters <- array(unique(ldply(kplx,.fun = NULL)$Quarter))
                quarters <- quarters[-1]
                values$quarters <- quarters
                values$oQuarters <- quarters
                values$kplxt <- kplxt
                
                qkpl <- kplxt[kplxt$Quarter %in% quarters,]
                
                values$minD <- min(qkpl$TimeFrame)
                values$maxD <- max(qkpl$TimeFrame)
                kplx
        })        
        
        #       Quarter selection
        range <- reactive({
                qsel <- if(length(input$qtrSel) == 0)values$oQuarters[1]
                else input$qtrSel
                qkpl <- values$kplxt[values$kplxt$Quarter %in% qsel,]
                qkpl
        })
        observe({
                if(input$clear_all == 0) return()
                values$quarters <- values$oQuarters[1]
        })
        observe({
                if(input$select_all == 0) return()
                values$quarters <- values$oQuarters
        })        
        qtr <- reactive({
                if(length(input$qtrSel) == 0)values$oQuarters[1]
                else input$qtrSel
        })
        
        #       Dates selection
        output$daysSel <- renderUI({
                sliderInput("daysSelection","Select days", 
                            as.integer(min(range()$TimeFrame)), 
                            as.integer(max(range()$TimeFrame)),
                            step = 1, value = c(values$minD,values$maxD), 
                            round = TRUE, width = 800)
        })        
        output$quarterSel <- renderUI({
                checkboxGroupInput('qtrSel', 'Quarters', values$oQuarters, selected=values$quarters, inline = TRUE)
        })
        
        #       Plot drawing
        #       Full plot
        output$SplitPlot <- renderPlot({
                if(input$View == '1'){
                        gPlotQuarterDataZoom(kpl(), qtr(), TRUE, 
                                             lowcl = input$DotColor, highcl = input$TranColor,
                                             lowTF = input$daysSelection[1], highTF = input$daysSelection[2],
                                             fitting = input$Fitting) 
                        
                }
                else{
                        gPlotQuarterData(kpl(), qtr(), TRUE, 
                                         lowcl = input$DotColor, highcl = input$TranColor,
                                         lowTF = input$daysSelection[1], highTF = input$daysSelection[2]) 
                }
        }, height = 800)
        #       Split plot
        output$FullPlot <- renderPlot({
                if(input$View == '1'){
                        gPlotQuarterDataZoom(kpl(), qtr(), FALSE, 
                                             lowcl = input$DotColor, highcl = input$TranColor,
                                             lowTF = input$daysSelection[1], highTF = input$daysSelection[2],
                                             fitting = input$Fitting) 
                }
                else{
                        gPlotQuarterData(kpl(), qtr(), FALSE, 
                                         lowcl = input$DotColor, highcl = input$TranColor,
                                         lowTF = input$daysSelection[1], highTF = input$daysSelection[2]) 
                }
        }, height = 600)
        
})
