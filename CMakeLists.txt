
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
    ${CMAKE_SOURCE_DIR}/matrix_multiplication.F90
    ${CMAKE_SOURCE_DIR}/task.F90
    ${CMAKE_SOURCE_DIR}/main.F90

)

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


enable_testing()


set(run_command0 "${CMAKE_BINARY_DIR}/task 100 3000 100 0")
set(run_command1 "${CMAKE_BINARY_DIR}/task 100 3000 100 1")
set(run_command2 "${CMAKE_BINARY_DIR}/task 100 3000 100 2")
set(run_command3 "${CMAKE_BINARY_DIR}/task 100 3000 100 3")
set(run_command4 "${CMAKE_BINARY_DIR}/task 100 3000 100 4")


set(UNIT_TEST_NAME0 "test0")
set(UNIT_TEST_NAME1 "test1")
set(UNIT_TEST_NAME2 "test2")
set(UNIT_TEST_NAME3 "test3")
set(UNIT_TEST_NAME4 "test4")





add_custom_target(check
     COMMAND ${CMAKE_CTEST_COMMAND}
     --force-new-ctest-process
     --verbose
     --output-on-failure
      && sh -c "gnuplot ${CMAKE_GRAPH_DIR}/gnuplotscmds.gnu"
)

add_test( NAME unit_tests
          COMMAND sh -c
         "rm -f ${CMAKE_GRAPH_DIR}/test* \
          && ${run_command0} \
          >> ${CMAKE_GRAPH_DIR}/${UNIT_TEST_NAME0} \
          && ${run_command1} \
          >> ${CMAKE_GRAPH_DIR}/${UNIT_TEST_NAME1} \
          && ${run_command2} \
          >> ${CMAKE_GRAPH_DIR}/${UNIT_TEST_NAME2} \
          && ${run_command3} \
          >> ${CMAKE_GRAPH_DIR}/${UNIT_TEST_NAME3} \
          && ${run_command4} \
          >> ${CMAKE_GRAPH_DIR}/${UNIT_TEST_NAME4}"
           )
















#
