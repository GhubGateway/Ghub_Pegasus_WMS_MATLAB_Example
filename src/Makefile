MAKE = make
PUFFINDIR = puffin/src/puffin
PUFFDIR = puffin/src/puff/puff-uaf-svn49
UDDIR = puffin/src/puff/udunits-1.12.11

$(info $$CURDIR is [${CURDIR}])
OUTDIR = $(subst /src,,$(CURDIR))
$(info $$OUTDIR is [${OUTDIR}])

default: all install

all: make-puff

install: puffin install-puff

#/bin/sh: 1: ./etc/environ.sh not found
#/bin/sh: 1: /ect/environ.sh permission denied

.PHONY:make-puff
make-puff: udunits
	. /etc/environ.sh; use -e -r netcdf-cxx-4.2; cd $(PUFFDIR); ./mdj-conf.sh $(OUTDIR);
	. /etc/environ.sh; use -e -r netcdf-cxx-4.2; cd $(PUFFDIR); $(MAKE);

.PHONY:install-puff
install-puff:
	cd $(PUFFDIR); $(MAKE) install;

.PHONY:udunits
udunits:
	cd $(UDDIR)/src; ./mdj-conf.sh $(OUTDIR)
	cd $(UDDIR)/src; $(MAKE); $(MAKE) install;
	cd $(OUTDIR)/etc; chmod 644 udunits.dat

.PHONY:puffin
puffin: 
	cd $(PUFFINDIR); $(MAKE) OUTDIR=$(OUTDIR)/bin;
	cd $(OUTDIR)/bin; chmod 755 puffin

clean:
	$(MAKE) -C $(PUFFDIR) clean
	$(MAKE) -C $(UDDIR)/src clean
	$(MAKE) -C $(PUFFINDIR) clean

distclean: clean
	cd $(OUTDIR); rm -rf bin/puff bin/puffin bin/udunits bin/ash* bin/grib2pf bin/mini_httpd bin/pp2nc bin/rereference.pl etc include lib man web
	$(MAKE) -C $(PUFFDIR) distclean
	$(MAKE) -C $(UDDIR)/src distclean
	$(MAKE) -C $(PUFFINDIR) distclean
