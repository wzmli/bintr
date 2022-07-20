library(tidyverse)
library(bbmle)
library(shellpipes)
loadEnvironments()

init_lK <- 5000

peak <- (fulldf
	%>% filter(Inc == max(Inc))
)

fitdf <- (fulldf
	%>% filter(t <= peak[["t"]])
)

print(fitdf,n=Inf)

m <- mle2(fitdf$Inc ~ dnbinom(mu=flexSim(lK, li0,rsim,time)$intSim, size=ss)
	, start = list(lK=log(init_lK),li0=1,rsim=0.05,ss=1)
	, data = fitdf
)

print(m)

