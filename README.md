# Project Title

Check the weather pattern in Davis. 
Data source here: http://apps.atm.ucdavis.edu/wxdata/data/

## Getting Started

Clone the repository, then call the R function in a Linux shell specifing the only two arguments:
```
Rscript howmuchrain.r "%j" 10

The first argument is the time grain

"%j" for days
"$W" for weeks
"%m"for months

the second is the time gap you want to consider for plotting data (i.e., 10 with "%j" will plot the cumulative precipitation in the last ten days and compare it with the last 10 years.)
```

Check the output with
```
eog /tmp/rain_davis_output.png
```

### Prerequisites

Runs only in Linux.
You will need eog, R as well as  ggplot2, utils, grid and GridExtra R packages.
```
