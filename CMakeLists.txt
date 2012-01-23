# $Id$

PROJECT (luafcgid)
CMAKE_MINIMUM_REQUIRED (VERSION 2.6)

OPTION (ENABLE_LUAJIT "Enable building with luajit")

IF (ENABLE_LUAJIT_STATIC OR ENABLE_LUAJIT)
	INCLUDE (FindLuaJIT.cmake)
ELSE (ENABLE_LUAJIT_STATIC OR ENABLE_LUAJIT)
	INCLUDE (FindLua.cmake)
ENDIF (ENABLE_LUAJIT_STATIC OR ENABLE_LUAJIT)

INCLUDE (FindFastCGI.cmake)

INCLUDE_DIRECTORIES (${LUA_INCLUDE_DIR} ${FASTCGI_INCLUDE_DIR} src)
LINK_DIRECTORIES (${LUA_LIBRARY_DIR})

SET (luafcgid_SOURCE_FILES
	src/main.c
	src/config.c
	src/pool.c
	src/buffer.c
	src/request.c
)

ADD_EXECUTABLE (luafcgid ${luafcgid_SOURCE_FILES})

TARGET_LINK_LIBRARIES (luafcgid ${LUA_LIBRARIES} ${FASTCGI_LIBRARIES})

INSTALL (TARGETS luafcgid DESTINATION bin)
INSTALL (PROGRAMS scripts/etc/init.d/luafcgid.debian DESTINATION /etc/init.d RENAME luafcgid)
INSTALL (FILES scripts/etc/config.debian.lua DESTINATION /etc/luafcgid RENAME config.lua)
INSTALL (FILES scripts/luafcgid.lua DESTINATION ${LUA_MODULE_DIR})
INSTALL (FILES docs/luafcgid.1.gz DESTINATION share/man/man1)
INSTALL (FILES docs/luafcgid-config.5.gz DESTINATION share/man/man5)
