--- storage/innobase/lz4.cmake.orig	2021-08-02 10:58:57 UTC
+++ storage/innobase/lz4.cmake
@@ -17,9 +17,16 @@ SET(WITH_INNODB_LZ4 AUTO CACHE STRING
 
 MACRO (MYSQL_CHECK_LZ4)
   IF (WITH_INNODB_LZ4 STREQUAL "ON" OR WITH_INNODB_LZ4 STREQUAL "AUTO")
-    CHECK_INCLUDE_FILES(lz4.h HAVE_LZ4_H)
-    CHECK_LIBRARY_EXISTS(lz4 LZ4_compress_limitedOutput "" HAVE_LZ4_SHARED_LIB)
-    CHECK_LIBRARY_EXISTS(lz4 LZ4_compress_default "" HAVE_LZ4_COMPRESS_DEFAULT)
+    find_path(LZ4_INCLUDE_DIR NAMES lz4.h)
+    find_library(LZ4_LIBRARY NAMES lz4)
+    IF (LZ4_LIBRARY)
+    get_filename_component(LZ4_LIBDIR ${LZ4_LIBRARY} DIRECTORY)
+#MESSAGE(STATUS "LZ4_INCLUDE_DIR=${LZ4_INCLUDE_DIR} LZ4_LIBRARY=${LZ4_LIBRARY} LZ4_LIBDIR=${LZ4_LIBDIR}")
+    IF (LZ4_INCLUDE_DIR)
+      SET(HAVE_LZ4_H YES)
+    ENDIF()
+    CHECK_LIBRARY_EXISTS(lz4 LZ4_compress_limitedOutput ${LZ4_LIBDIR} HAVE_LZ4_SHARED_LIB)
+    CHECK_LIBRARY_EXISTS(lz4 LZ4_compress_default ${LZ4_LIBDIR} HAVE_LZ4_COMPRESS_DEFAULT)
 
     IF (HAVE_LZ4_SHARED_LIB AND HAVE_LZ4_H)
       SET(HAVE_INNODB_LZ4 TRUE)
@@ -27,11 +34,12 @@ MACRO (MYSQL_CHECK_LZ4)
       IF (HAVE_LZ4_COMPRESS_DEFAULT)
         ADD_DEFINITIONS(-DHAVE_LZ4_COMPRESS_DEFAULT=1)
       ENDIF()
-      LINK_LIBRARIES(lz4)
+      LINK_LIBRARIES(${LZ4_LIBRARY})
     ELSE()
       IF (WITH_INNODB_LZ4 STREQUAL "ON")
         MESSAGE(FATAL_ERROR "Required lz4 library is not found")
       ENDIF()
+    ENDIF()
     ENDIF()
   ENDIF()
   ADD_FEATURE_INFO(INNODB_LZ4 HAVE_INNODB_LZ4 "LZ4 compression in the InnoDB storage engine")