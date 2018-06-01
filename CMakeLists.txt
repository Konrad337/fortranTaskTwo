
cmake_minimum_required(VERSION 3.5)
project (lab_project_1)
file(GLOB SOURCES "./src/*.F90")
enable_language (Fortran)

set (CMAKE_Fortran_COMPILER ifort)
message("Set fortran compiler to ${CMAKE_Fortran_COMPILER}")

set(CMAKE_SOURCE_DIR ${CMAKE_SOURCE_DIR}/src)
set(CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/../bin)
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(CMAKE_TEST_DIR ${CMAKE_SOURCE_DIR}/../tests)
set(CMAKE_GRAPH_DIR ${CMAKE_SOURCE_DIR}/../graphs)

set(TASK_SOURCES
    ${CMAKE_SOURCE_DIR}/task.F90
    ${CMAKE_SOURCE_DIR}/gauss.F90
${CMAKE_SOURCE_DIR}/matrice_ops.F90)
set(TEST_SOURCES
    ${CMAKE_SOURCE_DIR}/tests.F90
    ${CMAKE_SOURCE_DIR}/gauss.F90
    ${CMAKE_SOURCE_DIR}/fruit.F90
${CMAKE_SOURCE_DIR}/matrice_ops.F90)


file(MAKE_DIRECTORY ${CMAKE_TEST_DIR})
file(MAKE_DIRECTORY ${CMAKE_GRAPH_DIR})

include_directories("${PROJECT_SOURCE_DIR}")
include_directories("${CMAKE_GRAPH_DIR}")


if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Release")
  set(CMAKE_BUILD_TYPE "Release")
#  set(CMAKE_BUILD_TYPE "Debug")
endif()

# FFLAGS depend on the compiler
get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU")
    set(dialect "-ffree-form -std=f2008 -fimplicit-none -cpp -Wall -pedantic")
    set(bounds "-fbounds-check")
    set(realeaseopts "-O3  -pthread -funroll-all-loops")
    set(debugopts "-O0 -g3 -fbacktrace -fcheck=all -fdump-fortran-optimized")
#    -DIINFO -DIDEBUG -DIPRINT")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "Intel")
    set(dialect "-std08  -module . -implicitnone -cpp -Wall -pedantic")
    set(bounds " -check bounds")
    set(realeaseopts "-funroll-all-loops -O3")
    set(debugopts "-O0 -g -traceback -check all -debug extended -debug-parameters all")
#    -DIINFO -DIDEBUG -DIPRINT")
endif()

set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${bounds}")
set(CMAKE_Fortran_FLAGS_DEBUG "${CMAKE_Fortran_FLAGS_DEBUG} ${debugopts}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${dialect}")
set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_RELEASE_FLAGS} ${realeaseopts}")


add_executable(task ${TASK_SOURCES})
add_executable(task4 ${TASK_SOURCES})
add_executable(task16 ${TASK_SOURCES})
set_target_properties(task PROPERTIES COMPILE_FLAGS "-D\"_KIND=8\"")
set_target_properties(task4 PROPERTIES COMPILE_FLAGS "-D\"_KIND=4\"")
set_target_properties(task16 PROPERTIES COMPILE_FLAGS "-D\"_KIND=16\"")



add_executable(tests ${TEST_SOURCES})


enable_testing()

set(run_command "${CMAKE_BINARY_DIR}/tests")
set(UNIT_TEST_NAME "unit_tests.txt")




add_custom_target(check
     COMMAND ${CMAKE_CTEST_COMMAND}
     --force-new-ctest-process
     --verbose
     --output-on-failure
      && sh -c "gnuplot ${CMAKE_GRAPH_DIR}/gnuplotscmds.gnu"
)

add_test( NAME unit_tests
          COMMAND sh -c
         "rm -f ${CMAKE_TEST_DIR}/${UNIT_TEST_NAME} \
          && ${run_command} \
          >> ${CMAKE_TEST_DIR}/${UNIT_TEST_NAME} \
          && less ${CMAKE_TEST_DIR}/${UNIT_TEST_NAME}"
          )
















#
