cmake_minimum_required(VERSION 3.10)
set(CMAKE_CXX_STANDARD 20)

project(cpp-template LANGUAGES CXX)

# Now we define some important build variables
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# If there was any header directories you should include, use the following statement
#
#     include_directories(<directory_path>)
#
# Generally we set variables with such important paths by the way

# Here we include subdirectories, in this case the project sources directory
#
# If you are building an library alongside, create a directory with a sub CMakeLists.txt
# for it
add_subdirectory(${CMAKE_SOURCE_DIR}/cpp-template ${CMAKE_SOURCE_DIR}/bin)
