current: target
-include target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt"

######################################################################

Sources += $(wildcard *.R)

## Functions
flexSim.Rout: flexSim.R
	$(pipeR)

## Test the functiosn
testsim.Rout: testsim.R flexSim.rda
	$(pipeR)

## Make a binned example with logistic 
example.Rout: example.R flexSim.rda
	$(pipeR)

## Fit it perfectly!
fit.Rout: fit.R example.rda flexSim.rda
	$(pipeR)

## Can we do some crude ts estimates with a lambda (discrete-time) paradigm?
lambda.Rout: lambda.R example.rda flexSim.rda
	$(pipeR)

######################################################################

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
