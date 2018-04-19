PAM_LIB_DIR ?= /lib/security
INSTALL ?= install
CFLAGS += -fPIC -fno-stack-protector
LDFLAGS += -x --shared

TITLE = pam_setquota
LIBSHARED = $(TITLE).so
LIBOBJ = $(TITLE).o

CC ?= cc
LD ?= ld
RM ?= rm

all: $(LIBSHARED)

$(LIBSHARED): $(LIBOBJ)
	$(LD) $(LDFLAGS) $(LIBOBJ) $(LDLIBS) -o $@

pam_setquota.o: pam_setquota.c
	$(CC) -c $(CPPFLAGS) $(CFLAGS) $< -o $@

install: $(LIBSHARED)
	$(INSTALL) -m 0755 -d $(DESTDIR)$(PAM_LIB_DIR)
	$(INSTALL) -m 0644 $(LIBSHARED) $(DESTDIR)$(PAM_LIB_DIR)

clean:
	$(RM) *.o *.so
