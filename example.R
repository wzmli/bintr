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

fulldf  <- (tibble(t=t)
	%>% mutate(Inc = flexSim(med,li0,r,t)[["intSim"]]
		, cinc = cumsum(Inc)
	)
)

print(fulldf)

trimdf <- (fulldf
	%>% filter(!(t %in% tt))
	%>% mutate(newInc = diff(c(0,cinc)))
)

ggfull <- (ggplot(fulldf,aes(x=t)))

ggfullcinc <- ggfull + geom_point(aes(y=cinc))
ggfullinc <- ggfull + geom_point(aes(y=Inc))



ggtrim <- ggfull %+% trimdf
ggtrimcinc <- ggtrim + geom_point(aes(y=cinc))
ggtriminc <- ggtrim + geom_point(aes(y=newInc))


ggcombo <- plot_grid(ggfullcinc,ggfullinc,ggtrimcinc,ggtriminc)

print(ggcombo)

saveVars(fulldf, trimdf)
