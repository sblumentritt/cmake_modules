# The following functions will be provided:
#   - add_postbuild_strip

include_guard(GLOBAL)

#[[

Helper function to strip binaries according to the build type as post build step.

add_postbuild_strip(<target>)

#]]
function(add_postbuild_strip target)
    if(UNIX)
        get_target_property(${target}_type ${target} TYPE)

        # static libraries should not be stripped
        if(${target}_type MATCHES "STATIC_LIBRARY")
            return()
        endif()

        if(CMAKE_BUILD_TYPE MATCHES "Release" OR CMAKE_BUILD_TYPE MATCHES "MinSizeRel")
            add_custom_command(
                TARGET
                    ${target}
                POST_BUILD
                COMMENT "[----] Strip symbols from target: ${target}"
                COMMAND
                    ${CMAKE_STRIP}
                    --strip-all
                    --discard-all
                    --discard-locals
                    --remove-section=.comment
                    --remove-section=.note*
                    $<TARGET_FILE:${target}>
            )
        elseif(CMAKE_BUILD_TYPE MATCHES "RelWithDebInfo")
            add_custom_command(
                TARGET
                    ${target}
                POST_BUILD
                COMMENT "[----] Strip symbols from target: ${target}"
                COMMAND
                    ${CMAKE_STRIP}
                    --strip-unneeded
                    --remove-section=.comment
                    --remove-section=.note*
                    $<TARGET_FILE:${target}>
            )
        endif()
    else()
        message(VERBOSE
            "System is not 'UNIX'! Function has no effect and should not be called."
        )
    endif()
endfunction()
