#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "xlsxio::xlsxio_read_STATIC" for configuration ""
set_property(TARGET xlsxio::xlsxio_read_STATIC APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(xlsxio::xlsxio_read_STATIC PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "/opt/homebrew/lib/libminizip.dylib;/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/lib/libz.tbd;/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/lib/libexpat.tbd"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libxlsxio_read.a"
  )

list(APPEND _cmake_import_check_targets xlsxio::xlsxio_read_STATIC )
list(APPEND _cmake_import_check_files_for_xlsxio::xlsxio_read_STATIC "${_IMPORT_PREFIX}/lib/libxlsxio_read.a" )

# Import target "xlsxio::xlsxio_write_STATIC" for configuration ""
set_property(TARGET xlsxio::xlsxio_write_STATIC APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(xlsxio::xlsxio_write_STATIC PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_NOCONFIG "C"
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "/opt/homebrew/lib/libminizip.dylib;/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/lib/libz.tbd"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libxlsxio_write.a"
  )

list(APPEND _cmake_import_check_targets xlsxio::xlsxio_write_STATIC )
list(APPEND _cmake_import_check_files_for_xlsxio::xlsxio_write_STATIC "${_IMPORT_PREFIX}/lib/libxlsxio_write.a" )

# Import target "xlsxio::xlsxio_read_SHARED" for configuration ""
set_property(TARGET xlsxio::xlsxio_read_SHARED APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(xlsxio::xlsxio_read_SHARED PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "/opt/homebrew/lib/libminizip.dylib;/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/lib/libz.tbd;/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/lib/libexpat.tbd"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libxlsxio_read.dylib"
  IMPORTED_SONAME_NOCONFIG "@rpath/libxlsxio_read.dylib"
  )

list(APPEND _cmake_import_check_targets xlsxio::xlsxio_read_SHARED )
list(APPEND _cmake_import_check_files_for_xlsxio::xlsxio_read_SHARED "${_IMPORT_PREFIX}/lib/libxlsxio_read.dylib" )

# Import target "xlsxio::xlsxio_write_SHARED" for configuration ""
set_property(TARGET xlsxio::xlsxio_write_SHARED APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(xlsxio::xlsxio_write_SHARED PROPERTIES
  IMPORTED_LINK_INTERFACE_LIBRARIES_NOCONFIG "/opt/homebrew/lib/libminizip.dylib;/Library/Developer/CommandLineTools/SDKs/MacOSX14.4.sdk/usr/lib/libz.tbd"
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libxlsxio_write.dylib"
  IMPORTED_SONAME_NOCONFIG "@rpath/libxlsxio_write.dylib"
  )

list(APPEND _cmake_import_check_targets xlsxio::xlsxio_write_SHARED )
list(APPEND _cmake_import_check_files_for_xlsxio::xlsxio_write_SHARED "${_IMPORT_PREFIX}/lib/libxlsxio_write.dylib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
