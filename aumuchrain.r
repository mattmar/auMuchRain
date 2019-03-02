#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)
x1=args[1]
x2=as.numeric(args[2])

rainDavis<-function(longtime=TRUE,shortime=TRUE,grain="%d",gap=2) { 
	library(gridExtra)
	library(grid)

	download.file("http://apps.atm.ucdavis.edu/wxdata/data/RR_Rain_mm.zip",destfile="/tmp/RR_Rain_mm.zip",extra="unzip")
	unzip(zipfile='/tmp/RR_Rain_mm.zip',overwrite=TRUE)
	rain<-read.csv('/tmp/RR_Rain_mm.csv',header=FALSE)

	if(longtime) {
		rain$V4<-as.POSIXct(rain$V4)
		rain$doy<-strftime(rain$V4, format = "%j")
		rain$week<-format(rain$V4,"%W")
		rain$month<-format(rain$V4,"%m")
		rain$year<-format(rain$V4,"%y")

		g1<-ggplot(rain,aes(y=V3,x=factor(year))) +stat_summary(fun.y="sum", geom="bar") +xlab("year") +ylab("sum of rain per year (2009- ;mm)") + theme_bw() +
		theme(axis.text.x=element_text(size=15))
		g2<-ggplot(rain,aes(y=V3,x=factor(month))) +stat_summary(fun.y="sum", geom="bar") +xlab("month") +ylab("sum of rain per month (2009- ;mm)") + theme_bw() +
		theme(axis.text.x=element_text(size=15))
		g3<-ggplot(rain,aes(y=V3,x=factor(week))) +stat_summary(fun.y="sum", geom="bar") +xlab("week") +ylab("sum of rain per week (2009- ;mm)") + theme_bw() +
		theme(axis.text.x=element_text(size=6,angle = 90))
		g4<-ggplot(rain,aes(y=V3,x=factor(doy))) +stat_summary(fun.y="sum", geom="bar") +xlab("Day of the year") +ylab("sum of rain per DOY (2009- ;mm)") + theme_bw() + theme(axis.text.x=element_text(size=15))
	}

	#Look at short time user defined time frames
	aumuchrain<-function(grain, gap) {

		if(grain%in%"%W")
		{
			tf<-"week/s"
			comrain<-rain[rain$week%in%format(seq(Sys.time()-3600*24*7*gap,Sys.time(),"1 week"),grain),]
			timerep<-aggregate(comrain$week,list(comrain$week,comrain$year),"length")$x
		}else if(grain%in%"%j") {
			tf<-"day/s"
			comrain<-rain[rain$doy%in%format(seq(Sys.time()-3600*24*gap,Sys.time(),"1 day"),"%j"),]
			timerep<-aggregate(comrain$doy,list(comrain$doy,comrain$year),"length")$x
		}else if(grain%in%"%m") {
			tf<-"month/s"
			comrain<-rain[rain$month%in%format(seq(Sys.time()-3600*24*30*gap,Sys.time(),"1 month"),grain),]
			timerep<-aggregate(comrain$month,list(comrain$month,comrain$year),"length")$x
		}else{
			stop("Wrong grain; use ISO date formats.")
		}


		comrain$f<-rep(1:length(timerep),timerep)
		comrain$f<-factor(comrain$f)
		comrain$f<-factor(comrain$f,levels=levels(comrain$f),ordered=T)

		levels(comrain$f)<-rep(c("this/last year/s",paste(-1:-((length(unique(comrain$year)))-1),"year/s")),each=gap)[1:nrow(comrain)]
		comrain<-comrain[(complete.cases(comrain)),]

		temp<-ggplot(comrain,aes(y=V3,x=f))+geom_col()+xlab(paste("Last",gap,tf,"(for different year)",sep=" ")) +ylab("Sum of rain for defined time from 2009- (mm)") + theme_bw() +scale_x_discrete()
		return(temp)
	}

	if(longtime&shortime)
	{
		ggst<-aumuchrain(grain,gap)
		ggsave("/tmp/rain_davis_output.png",grid.arrange(grid.arrange(g1, g2, g3, g4, ncol=2),ggst,nrow=2),width=15,height=10)
	}else if(shortime){
		ggst
	}
}

rainDavis(longtime=TRUE,shortime=TRUE,grain=x1,gap=x2)