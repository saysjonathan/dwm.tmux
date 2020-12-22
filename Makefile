PREFIX=/usr/local
BINDIR=${PREFIX}/bin
LIBDIR=${PREFIX}/lib

.PHONY: install bin lib

install: dirs bin lib

dirs:
	install -d ${BINDIR} ${LIBDIR}

lib:
	cp lib/* ${LIBDIR}/

bin:
	cp bin/* ${BINDIR}/

uninstall:
	rm ${BINDIR}/dwm.tmux
	rm ${LIBDIR}/dwm.tmux

