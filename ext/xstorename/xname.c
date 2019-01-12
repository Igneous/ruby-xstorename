#include <X11/Xlib.h>
#include <ruby.h>
#include <stdio.h>
#include <stdlib.h>
#include "extconf.h"

int set_xname(VALUE _self, VALUE msg)
{
  Check_Type(msg, T_STRING);
  VALUE result = Qnil;

  Display *dpy;
  Window rootwin;
  int scr;

  if(!(dpy=XOpenDisplay(NULL))) {
    rb_raise(rb_eRuntimeError, "ERROR: could not open X11 display.");

  }

	scr = DefaultScreen(dpy);
	rootwin = RootWindow(dpy, scr);

	XStoreName(dpy, rootwin, StringValueCStr(msg));

	XCloseDisplay(dpy);

	return result;
}

void Init_XStoreName() {


    VALUE mod = rb_define_module("XStoreName");
    rb_define_module_function(mod, "set_xname", set_xname, 1);
}
