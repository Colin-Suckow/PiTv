# Quiet, graphical boot for the plymouth splash:
#   quiet                          - suppress most kernel console noise
#   splash                         - tell plymouth to show the splash
#   plymouth.ignore-serial-consoles- don't draw to the serial console
#   vt.global_cursor_default=0     - hide the blinking text cursor
CMDLINE:append = " quiet splash plymouth.ignore-serial-consoles vt.global_cursor_default=0"
