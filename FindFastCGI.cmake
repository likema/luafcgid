# Locate FastCGI library
# This module defines
#  FASTCGI_FOUND, if false, do not try to link to fcgi
#  FASTCGI_LIBRARIES
#  FASTCGI_INCLUDE_DIR, where to find fcgiapp.h

OPTION (ENABLE_FASTCGI_STATIC "Enable static linking fastcgi" OFF)

FIND_PATH (FASTCGI_INCLUDE_DIR fcgiapp.h
	HINTS
	$ENV{FASTCGI_DIR}
	PATH_SUFFIXES include
	PATHS
	~/Library/Frameworks
	/Library/Frameworks
	/usr/local
	/usr
	/sw # Fink
	/opt/local # DarwinPorts
	/opt/csw # Blastwave
	/opt
)

IF (ENABLE_FASTCGI_STATIC)
	FIND_LIBRARY (FASTCGI_LIBRARY
		NAMES libfcgi.a
		HINTS
		$ENV{FASTCGI_DIR}
		PATH_SUFFIXES lib64 lib
		PATHS
		~/Library/Frameworks
		/Library/Frameworks
		/usr/local
		/usr
		/sw
		/opt/local
		/opt/csw
		/opt
	)
ELSE (ENABLE_FASTCGI_STATIC)
	FIND_LIBRARY (FASTCGI_LIBRARY
		NAMES fcgi
		HINTS
		$ENV{FASTCGI_DIR}
		PATH_SUFFIXES lib64 lib
		PATHS
		~/Library/Frameworks
		/Library/Frameworks
		/usr/local
		/usr
		/sw
		/opt/local
		/opt/csw
		/opt
	)
ENDIF (ENABLE_FASTCGI_STATIC)

IF (FASTCGI_LIBRARY)
	IF (ENABLE_FASTCGI_STATIC)
		SET (FASTCGI_LIBRARIES "${FASTCGI_LIBRARY};pthread" CACHE STRING "FastCGI Libraries")
	ELSE (ENABLE_FASTCGI_STATIC)
		SET (FASTCGI_LIBRARIES "${FASTCGI_LIBRARY}" CACHE STRING "FastCGI Libraries")
	ENDIF (ENABLE_FASTCGI_STATIC)
ENDIF(FASTCGI_LIBRARY)

FIND_PACKAGE (PackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(FastCGI DEFAULT_MSG FASTCGI_LIBRARIES FASTCGI_INCLUDE_DIR)
MARK_AS_ADVANCED(FASTCGI_INCLUDE_DIR FASTCGI_LIBRARIES FASTCGI_LIBRARY)
