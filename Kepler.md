
Kepler light curves visualization
====

### Background

Kepler mission was launched by NASA on March 2009 with the aim of detecting and caracterizing extrasolar planets orbiting sun-like stars <http://www.nasa.gov/mission_pages/kepler/main/>.  
Those planets should be found using the *transit method*, that is, measuring with an extreme precision the light emitted by the host star over a long period and identifying any significant dim on brightness <http://en.wikipedia.org/wiki/Methods_of_detecting_exoplanets#Transit_photometry>.  
The Kepler telescope surveys continuously up to 100000 stars and records their brightness over time, producing a *ligth curve* for each one that shows the received light variation. 

### Source data for this assignment

As the mission started to gather data, light curves where made public. <https://www.zooniverse.org/>, a free to join organization to bring science to people, started an initiative to help NASA to identify planet candidates from the huge amount of curves available <http://www.planethunters.org/>.  
This planethunters project allowed initially to everybody downloading the data curves for every star directly from their site for whatever the use. That information was provided in CSV files, easily manageable.    
Unfortunately, the current version of the website (after some changes over time) doesn't have that option anymore. However I could donwload some light curves in the past and did some data cleaning (removing bad data, setting correctly the time frame, normalize the brightness, marking transits...).  
The outcome of my previous work are the .RDS files that you can view right now using this application.  

### What I can do with this application?  

When the application loads you will see two sections:  
* Side control panel

#### Main Tab menu  
The user can switch between the *Plotting Data* application and the *About* section, where this manual is displayed

#### Sidebar area  
* Kepler light Curves radiobutton selector: Allows the user to import one of the currently available light curves  
  * KPLR stands for basic Kepler exploration
  * KIC stands for serious exoplanet candidate
  * KOI stands for Keppler Object of Interest
  
* Dot color: Indicates the color to plot every normal light point in the curve  
  * Useful to have an idea of what the normal behaviour of the star is (regarding to luminosity)  

* Transit color: Indicates the colot to plot the eventual transit points (dims in the light curve luminosity)  
  * Useful to see de diference between the normal behaviour and the transit-like behaviour  
  * This color is lighter as deeper the transit (or anomaly) is  
  * Not all the dims on the light curve are real transits, can be variable stars light fluctuations, sunspots, binary stars...  
  
* View: two ways to plot the lightcurve  
  * Regular: the light curve luminosity as it was released as a function of time (days) with no processing  
  * Zoomed: only displays the transit-like points and their neighbourhood of regular points  

* Quarters: The data was collected in "Quarters" (about 30 days)  
  * It will be always a selected quarter (the first one recorded)  
  * Useful to explore the time segments containing transits  
  
* Clear Selection / Select all: Allows the user to select all or none (only de default) of the quarters  
  * Note that there are curves from the first release of data (only two quarters) and others from later releases (10 or more quarters)  

#### Main display area
There are two main selector in this area  

* Full Plot: Plots all the selected quarters of data in a unique chart.  
  * Useful to have an idea of the behaviour of the light in a long term of observation  
  * There's an slide control to adjust the zooming over the plot by selecting the days of measures to display  
  * When *Zoomed* view is selected, there's the option of adding a fitting curve to the chart to better see the transit shape. Controlling this option is a bit tricky since fitting curves behave weirdly with too many points  
  
 * Split plot: Plots the selected quarters individually  
   * Useful to avoid blank quarters of data (something that happened throghout the mission)  
   * Useful to identify the more interesting quarters in terms of transits  
 
#### Possible improvements on the application  
There are of course some improvements I could make in the future:  

* Better refreshing control of the chart under user interaction  
* Enabling / Disabling options according to parameter selection  
* Allow more analytic options directly on the chart  
* Use an enhanced chart framework as rCharts instead ggplot2  
