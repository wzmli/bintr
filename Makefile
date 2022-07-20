current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += $(wildcard *.R)

autopipeR = defined

## test Sims
flexSim.Rout: flexSim.R
	$(pipeR)

sim.Rout: sim.R flexSim.rda
	$(pipeR)

example.Rout: example.R flexSim.rda
	$(pipeR)

fit.Rout: fit.R example.rda flexSim.rda
	$(pipeR)

### Makestuff

Sources += Makefile

## Sources += content.mk
## include content.mk

Ignore += makestuff
msrepo = https://github.com/dushoff

Makefile: makestuff/Makefile
makestuff/Makefile:
	git clone $(msrepo)/makestuff
	ls makestuff/Makefile

-include makestuff/os.mk

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk