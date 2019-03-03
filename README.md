# Project Title

Check the weather pattern in Davis. 
Data source here: http://apps.atm.ucdavis.edu/wxdata/data/

## Getting Started

Clone the repository, then call the R function in a Linux shell specifing the only two arguments:
```
Rscript aumuchrain.r "%j" 10
```
The first argument is the time grain:
```
"%j" for days
"$W" for weeks
"%m"for months
```
the second argument is the time gap considered for plotting data (i.e., 10 with "%j" will plot the cumulative precipitation in the last ten days and compare it with data from the same time span for each of the last 10 years.)


Check the output:
```
eog /tmp/rain_davis_output.png
```

### Prerequisites

Runs only in Linux systems.
You will need eog, R as well as  ggplot2, utils, grid and GridExtra R packages.
