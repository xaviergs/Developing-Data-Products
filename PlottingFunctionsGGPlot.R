###################################################################
library(ggplot2)
library(plyr)
library(grDevices)
#       Setting fonts
# windowsFonts(
#         A=windowsFont("Trebuchet MS"),
#         B=windowsFont("Verdana"),
#         C=windowsFont("Tahoma"),
#         D=windowsFont("Helvetica")
# )
###################### PLOTTING BY GGPLOT FUNCTIONS ################
##      SELECTED QUARTERS: WHOLE SET OR BY SPLIT
gPlotQuarterData <- function(x, q, qsplit = FALSE, nodup = TRUE, showlegend = "none",
                             lowcl = "black", highcl = "darkcyan",
                             lowTF = 0, highTF = 1500){
        #       For lists: does the unsplit and then the plain brightness plot
        if(class(x) == "list") x <- ldply(x, .fun = NULL)
        #       Lists of quarters to plot
        xQ <- x[x$Quarter %in% q,]
        xQ$Quarter <- as.double(as.character(xQ$Quarter))
        #       Avoid duplicated values in time frame
        if(nodup == TRUE) xQ <- xQ[!duplicated(xQ$TimeFrame),]
        #       Plots brightness vs time by quarter
        
        #       Gets the low and hig percentages of data
        if(qsplit == FALSE) xQ <- subset(xQ,xQ$TimeFrame >= lowTF & xQ$TimeFrame <= highTF)
        
        #               Data selection for x and y
        go <- ggplot(xQ,aes(TimeFrame,Brightness))
        
        go <- go + scale_colour_gradient(low = lowcl, high = highcl)
        
        #               Sets the geom for point, size, color...
        go <- go + geom_point(aes(color = IsTransit, alpha = IsTransit - 1 / 25),
                              size = 4, pch = 20, font_family = "A")
        #               Theme
        go <- go + theme_bw()
        go <- go + theme(legend.position = showlegend) 
        
        #               If splitting by quarter, sets the facet wrap
        if(qsplit == TRUE){
                go <- go + facet_wrap(~ Quarter, ncol = 3, scales ="free_x")
        }
        #               labels
        go <- go + xlab("Days")
        go <- go + ylab("Scaled Brightness")
        print(go)
        
}
##      SELECTED QUARTERS: PLOT AROUND A TRANSIT
gPlotQuarterDataZoom <- function(x, q, qsplit = FALSE, nodup = TRUE,
                                 showlegend = "none",lowcl = "black", highcl = "darkcyan", zl = 0,
                                 lowTF = 0, highTF = 1500, fitting = TRUE){
        #       For lists: does the unsplit and then the plain brightness plot
        if(class(x) == "list") x <- ldply(x, .fun = NULL)
        #       Lists of quarters to plot
        xQ <- x[x$Quarter %in% q,]
        xQ$Quarter <- as.double(as.character(xQ$Quarter))
        #       Avoid duplicated values in time frame
        if(nodup == TRUE) xQ <- xQ[!duplicated(xQ$TimeFrame),]
        #       Gets only the data marked as transit (types 1 and 2)
        xQ <- xQ[which(xQ$IsTransit > zl),]
        
        #       Plots brightness vs time by quarter
        #       Gets the low and hig percentages of data
        if(qsplit == FALSE) xQ <- subset(xQ,xQ$TimeFrame >= lowTF & xQ$TimeFrame <= highTF)
        #               Data selection for x and y
        go <- ggplot(xQ,aes(TimeFrame,Brightness))
        go <- go + scale_colour_gradient(low = lowcl ,high = highcl)        
        #               Sets the geom for point, size, color...
        go <- go + geom_point(aes(color = IsTransit, alpha = IsTransit / 2 ),
                              size = 4, pch = 20, font_family = "A")
        #               Theme
        go <- go + theme_bw()
        go <- go + theme(legend.position = showlegend) 
        
        #               If splitting by quarter, sets the facet wrap
        if(qsplit == TRUE){
                go <- go + facet_wrap(~ Quarter, ncol = 3
                                      , scales = "free")
        }
        #               Adds the fitting for zoomed transits
        if(fitting == TRUE) go <- go + geom_smooth(fill = "gray85", alpha = 0.5)
        #               labels
        go <- go + xlab("Days")
        go <- go + ylab("Scaled Brightness")
        print(go)
        
}
