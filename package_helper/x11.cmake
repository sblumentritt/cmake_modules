# Provides function to link X11 to target.
#
# The following function will be provided:
#     link_x11_to_target - links X11 to target
#
# NOTE: On including the file the library is searched. If the library is not found a 'FATAL_ERROR'
#       message is thrown.

include_guard(GLOBAL)

# search for x11 library
find_package(X11 REQUIRED)

# check against X11_FOUND which is always required
if(NOT X11_FOUND)
    message(FATAL_ERROR "X11 not found!")
endif()

#[[

Helper function to link X11 to the given target.

link_x11_to_target(<target>)

The following cache variables will be set/provided:
    <project-name>_use_x11_xft - True if X11 Xft was found.
    <project-name>_use_x11_xext - True if X11 Xext was found.
    <project-name>_use_x11_xrandr - True if X11 Xrandr was found.
    <project-name>_use_x11_xinerama - True if X11 Xinerama was found.

#]]
function(link_x11_to_target target)
    target_link_libraries(${target} X11::X11)

    # define option for usage
    set(${PROJECT_NAME}_use_x11_xft ON
        CACHE
            BOOL "X11 Xft will be used"
    )

    set(${PROJECT_NAME}_use_x11_xext ON
        CACHE
            BOOL "X11 Xext will be used"
    )

    set(${PROJECT_NAME}_use_x11_xrandr ON
        CACHE
            BOOL "X11 Xrandr will be used"
    )

    set(${PROJECT_NAME}_use_x11_xinerama ON
        CACHE
            BOOL "X11 Xinerama will be used"
    )

    if(NOT X11_Xft_FOUND)
        message(STATUS "X11 Xft not found!")
        set(${PROJECT_NAME}_use_x11_xft OFF
            CACHE
                BOOL "X11 Xft will be used"
            FORCE
        )
    endif()

    if(NOT X11_Xext_FOUND)
        message(STATUS "X11 Xext not found!")
        set(${PROJECT_NAME}_use_x11_xext OFF
            CACHE
                BOOL "X11 Xext will be used"
            FORCE
        )
    endif()

    if(NOT X11_Xrandr_FOUND)
        message(STATUS "X11 Xrandr not found!")
        set(${PROJECT_NAME}_use_x11_xrandr OFF
            CACHE
                BOOL "X11 Xrandr will be used"
            FORCE
        )
    endif()

    if(NOT X11_Xinerama_FOUND)
        message(STATUS "X11 Xinerama not found!")
        set(${PROJECT_NAME}_use_x11_xinerama OFF
            CACHE
                BOOL "X11 Xinerama will be used"
            FORCE
        )
    endif()

    if(${PROJECT_NAME}_use_x11_xft AND X11_Xft_FOUND)
        target_link_libraries(${target} X11::Xft)
    endif()

    if(${PROJECT_NAME}_use_x11_xext AND X11_Xext_FOUND)
        target_link_libraries(${target} X11::Xext)
    endif()

    if(${PROJECT_NAME}_use_x11_xrandr AND X11_Xrandr_FOUND)
        target_link_libraries(${target} X11::Xrandr)
    endif()

    if(${PROJECT_NAME}_use_x11_xinerama AND X11_Xinerama_FOUND)
        target_link_libraries(${target} X11::Xinerama)
    endif()
endfunction()