CC=g++
LD=g++
#O2 for optimization, g for debugging
CFLAGS=-std=c++11 -Wall -O2 -g #-I. $(shell root-config --cflags)
MAKEDEPEND = $(CC) -MT $@ -MM -MP
#LFLAGS=$(shell root-config --libs)
LFLAGS=

#Alle Klassen cc-Dateien. Fuege hier weitere Klassen hinzu
SRCS=Vektor.cc Zylindermantel.cc #Vollzylinder.cc

OBJS = $(SRCS:.cc=.o)

.PHONY: clean all

all: traegheit vektortest

clean:
	@rm -f *~ *.o *# *.d main

traegheit: $(OBJS) traegheit.o
	$(LD) $(LFLAGS) -o traegheit $^

vektortest: $(OBJS) vektortest.o
	$(LD) $(LFLAGS) -o vektortest $^

%.o: %.cc


#rules
%.o : %.cc %.d
	$(MAKEDEPEND) -o $*.Td $<
	$(CC) $(CFLAGS) -c -o $@ $<
	mv -f $*.Td $*.d

%.d: ;
.PRECIOUS: %.d

-include $(SRCS:%.cc=%.d)

