# Ceres Solver - A fast non-linear least squares minimizer
# Copyright 2017 Google Inc. All rights reserved.
# http://ceres-solver.org/
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# * Neither the name of Google Inc. nor the names of its contributors may be
#   used to endorse or promote products derived from this software without
#   specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Author: alexs.mac@gmail.com (Alex Stewart)

# Adds Ceres' C++11 requirements to a target such that they are exported when
# the target is exported (if the version of CMake supports it).
#
#    add_ceres_cxx11_requirements_to_target( [target1 [target2 [...]]] )
function(add_ceres_cxx11_requirements_to_target)
  include(CheckCXXCompilerFlag)
  check_cxx_compiler_flag("-std=c++11" COMPILER_HAS_CXX11_FLAG)

  foreach(TARGET ${ARGN})
    if (NOT TARGET ${TARGET})
      message(FATAL_ERROR "Specified target to append Ceres C++11 requirements "
        "to: ${TARGET} is not a declared CMake target.")
    endif()

    if (COMPILER_HAS_CXX11_FLAG)
        target_compile_options(${TARGET} PUBLIC
          $<$<NOT:$<STREQUAL:$<TARGET_PROPERTY:LINKER_LANGUAGE>,C>>:-std=c++11>)
    endif()
  endforeach()
endfunction()
