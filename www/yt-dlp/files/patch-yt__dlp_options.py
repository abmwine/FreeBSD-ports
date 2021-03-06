--- yt_dlp/options.py.orig	2021-09-25 00:59:59 UTC
+++ yt_dlp/options.py
@@ -202,10 +202,6 @@ def parseOpts(overrideArguments=None):
         action='version',
         help='Print program version and exit')
     general.add_option(
-        '-U', '--update',
-        action='store_true', dest='update_self',
-        help='Update this program to latest version. Make sure that you have sufficient permissions (run with sudo if needed)')
-    general.add_option(
         '-i', '--ignore-errors',
         action='store_true', dest='ignoreerrors',
         help='Ignore download and postprocessing errors. The download will be considered successfull even if the postprocessing fails')
