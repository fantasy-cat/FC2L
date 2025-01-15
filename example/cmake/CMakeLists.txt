# CMakeList.txt : CMake project for fc2sample, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

# Enable Hot Reload for MSVC compilers if supported.
if (POLICY CMP0141)
  cmake_policy(SET CMP0141 NEW)
  set(CMAKE_MSVC_DEBUG_INFORMATION_FORMAT "$<IF:$<AND:$<C_COMPILER_ID:MSVC>,$<CXX_COMPILER_ID:MSVC>>,$<$<CONFIG:Debug,RelWithDebInfo>:EditAndContinue>,$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>>")
endif()

project ("fc2sample")

# Add source to this project's executable.
add_library(fc2sample SHARED "fc2sample.cpp" "fc2sample.h")

if (CMAKE_VERSION VERSION_GREATER 3.12)
  set_property(TARGET fc2sample PROPERTY CXX_STANDARD 20)
endif()

# Add FC2T/L directories and files
set(LUA_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/fc2l")
target_include_directories(fc2sample PRIVATE "${LUA_INCLUDE_DIR}")

# Link to FC2T/L libraries
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
	set(LUA_LIB_DIR "${CMAKE_SOURCE_DIR}/fc2l/windows")
	target_link_directories(fc2sodium PRIVATE "${LUA_LIB_DIR}")
	target_link_libraries(fc2sodium PRIVATE lua51.lib luajit.lib buildvm.lib minilua.lib)
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
	set(LUA_LIB_DIR "${CMAKE_SOURCE_DIR}/fc2l/linux")
	target_link_directories(fc2sodium PRIVATE "${LUA_LIB_DIR}")
	target_link_libraries(fc2sodium PRIVATE libluajit.a)
endif()