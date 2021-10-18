--- cmake/ssl.cmake.orig	2019-09-20 08:30:51 UTC
+++ cmake/ssl.cmake
@@ -199,7 +199,7 @@ MACRO (MYSQL_CHECK_SSL)
       # Encoded as MNNFFPPS: major minor fix patch status
       FILE(STRINGS "${OPENSSL_INCLUDE_DIR}/openssl/opensslv.h"
         OPENSSL_VERSION_NUMBER
-        REGEX "^#[ ]*define[\t ]+OPENSSL_VERSION_NUMBER[\t ]+0x[0-9].*"
+        REGEX "^#[\t ]*define[\t ]+OPENSSL_VERSION_NUMBER[\t ]+0x[0-9].*"
         )
       STRING(REGEX REPLACE
         "^.*OPENSSL_VERSION_NUMBER[\t ]+0x([0-9]).*$" "\\1"
@@ -222,13 +222,14 @@ MACRO (MYSQL_CHECK_SSL)
         OPENSSL_FIX_VERSION "${OPENSSL_VERSION_NUMBER}"
         )
     ENDIF()
-    IF("${OPENSSL_MAJOR_VERSION}.${OPENSSL_MINOR_VERSION}.${OPENSSL_FIX_VERSION}" VERSION_GREATER "1.1.0")
-       ADD_DEFINITIONS(-DHAVE_TLSv13)
+    CHECK_SYMBOL_EXISTS(TLS1_3_VERSION "openssl/tls1.h" HAVE_TLS1_3_VERSION)
+    IF(HAVE_TLS1_3_VERSION)
+       #ADD_DEFINITIONS(-DHAVE_TLSv13)
     ENDIF()
     IF(OPENSSL_INCLUDE_DIR AND
        OPENSSL_LIBRARY   AND
        CRYPTO_LIBRARY      AND
-       OPENSSL_MAJOR_VERSION STREQUAL "1"
+       OPENSSL_MAJOR_VERSION VERSION_GREATER_EQUAL "1"
       )
       SET(OPENSSL_FOUND TRUE)
       FIND_PROGRAM(OPENSSL_EXECUTABLE openssl