library(dplyr)
library(shellpipes)
startGraphics()

## log K for estimation stability
flexCum <- function(K, i0, r,t){
	decay <- exp(-r*t)
	if (K==Inf) return(i0/decay)
	return(K/(1+((K/i0)-1)*decay))
}

flexSim <- function(lK,li0, rsim, t){
	sim <- tibble(time = 0:max(t))
	ints <- tibble(time=t)

	sim <- (sim
		%>% mutate(cumSim = flexCum(K=exp(lK),i0=exp(li0),r=rsim,t=time))
	)
	return(left_join(ints, sim, by="time")
		%>% mutate(NULL
			,	intSim = diff(c(0, cumSim))
		)
	%>% select(-cumSim)
	)
}

saveVars(flexCum, flexSim)

