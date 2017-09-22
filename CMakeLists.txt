cmake_minimum_required(VERSION 2.8.2)

# Download and unpack googletest at configure time
configure_file(CMakeLists.txt.in googletest-download/CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "CMake step for googletest failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/googletest-download )
if(result)
  message(FATAL_ERROR "Build step for googletest failed: ${result}")
endif()

# Prevent overriding the parent project's compiler/linker
# settings on Windows
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Add googletest directly to our build. This defines
# the gtest and gtest_main targets.
add_subdirectory(${CMAKE_BINARY_DIR}/googletest-src
                 ${CMAKE_BINARY_DIR}/googletest-build)

# The gtest/gtest_main targets carry header search path
# dependencies automatically when using CMake 2.8.11 or
# later. Otherwise we have to add them here ourselves.
if (CMAKE_VERSION VERSION_LESS 2.8.11)
  include_directories("${gtest_SOURCE_DIR}/include"
                      "${gmock_SOURCE_DIR}/include")
endif()

include(CTest)

SET(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/CMakeModules)
INCLUDE (qtMake)

SET (QT_QMAKE_EXECUTABLE /home/pcarmona/apps/Qt-4.8.6/bin/qmake )
#SET (QT_MOC_EXECUTABLE   /home/pcarmona/apps/Qt-4.8.6/bin/moc )
#SET (QT_UI_EXECUTABLE    /home/pcarmona/apps/Qt-4.8.6/bin/uic )
#SET (QT_QRC_EXECUTABLE   /home/pcarmona/apps/Qt-4.8.6/bin/rcc )
SET(CMAKE_INCLUDE_PATH "/home/pcarmona/apps/Qt-4.8.6/bin")
FIND_PACKAGE(Qt4 4.8.6 REQUIRED QtCore QtNetwork QtTest)
include(${QT_USE_FILE})

set (SRC src/example.cpp)
set (SRC_H_MOC src/example.h)
set (SRC_MOC_GEN "src/autogen")

IF (NOT EXISTS ${SRC_MOC_GEN})
   execute_process (COMMAND mkdir -p ${SRC_MOC_GEN})
ENDIF()

gen_moc (TEST_MOC
        ${SRC_MOC_GEN}
        ${SRC_H_MOC})

# Now simply link against gtest or gtest_main as needed. Eg
add_executable(example_test test/main.cpp ${TEST_MOC} ${SRC})
target_link_libraries(example_test gtest_main)
target_link_libraries(example_test gtest gmock)
target_link_libraries(example_test ${QT_LIBRARIES})

add_test(NAME example_test COMMAND example)

if(CMAKE_COMPILER_IS_GNUCXX)
    include(CodeCoverage)
    APPEND_COVERAGE_COMPILER_FLAGS()
    set(COVERAGE_EXCLUDES '*/googletest-src/*' '*/usr/*' '*/apps/*' '*/build/*')
    set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1)
    #setup_target_for_coverage(${PROJECT_NAME}_coverage ${PROJECT_TEST_NAME} coverage)
    SETUP_TARGET_FOR_COVERAGE(
       #SETUP_TARGET_FOR_COVERAGE_COBERTURA(
       NAME example_coverage
       EXECUTABLE example_test
       DEPENDENCIES example_test)
    #     NAME testrunner_coverage                    # New target name
    #     EXECUTABLE testrunner -j ${PROCESSOR_COUNT} # Executable in PROJECT_BINARY_DIR
    #     DEPENDENCIES testrunner                     # Dependencies to build first

endif()
