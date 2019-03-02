# Project Title

Check the weather pattern in Davis. 
Data source here: http://apps.atm.ucdavis.edu/wxdata/data/

## Getting Started

Clone the repository, then call the R function with arguments:
```
Rscript howmuchrain.r "%j" 10
"%j" for days
"$W" for weeks
"%m"for months

the secund argument is the time gap you want to consider for plotting data (i.e., 10 with "%j" will plot the cumulative precipitation in the last ten days and compare it with the last 10 years.)
```

Check the output with
```
eog /tmp/rain_davis_output.png
```
in a Linux shell

### Prerequisites

Runs only on Linux
You will need R, ggplot2, utils and grid and GridExtra packages
```
