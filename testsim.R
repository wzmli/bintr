library(tidyverse); theme_set(theme_bw(base_size=18))
library(cowplot)
library(shellpipes)
startGraphics()

loadEnvironments()

t <- 0:50
li0 <- 1
r <- 0.2
large <- log(1e6)
med <- log(1e4)

tt <- sample(0:50,25)

print(tt)

print(flexSim(large,li0,r,t),n=Inf)

df <- (tibble(t=t)
	%>% mutate(NULL
		, expInc = flexSim(Inf, li0, r,t)[["intSim"]]
		, largeInc = flexSim(large, li0, r,t)[["intSim"]]
		, medInc = flexSim(med, li0, r,t)[["intSim"]]
	)
	%>% filter(t>0)
)
print(df,n=Inf)

simPlot <- (ggplot(df)
	+ aes(x=t)
	+ geom_point(aes(y=expInc),color="black")
	+ geom_line(aes(y=largeInc),color="red")
	+ geom_line(aes(y=medInc),color="blue")
	+ xlab("Interval incidence")
)

print(simPlot)
print(simPlot + scale_y_log10())

