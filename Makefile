OOC_FLAGS+=-v -driver=sequence -g

all:
	ooc -sourcepath=source/ ${OOC_FLAGS} main

slave:
	OOC_FLAGS="-slave" make

clean:
	rm -rf ooc_tmp/ main
