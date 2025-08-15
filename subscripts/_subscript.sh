#!/bin/bash
# ===--------------------------------------------------------------------------------------------===
# Copyright © 2025 Deus
#
# This file is part of the Deus open-source project.
#
# This program is free software: you can redistribute it and/or modify it under the terms of the GNU
# General Public License as published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with this program. If not,
# see https://www.gnu.org/licenses.
# ===--------------------------------------------------------------------------------------------===

# /subscripts/_subscript.sh
#
# Performs the initial configuration of a subscript. Must be the first execution of each subscript.

set -e

#
# Asserts that the caller process has been executed by Xcode and/or the main script, Deus.sh.
# --------------------------------------------------------------------------------------------------
#
# - Parameters: none
# - Returns:    void
assert_is_attached() {
  local is_attached=$([[ -n "$SRCROOT" ]]; echo $?)
  if [[ "$is_attached" -eq 0 ]]; then return; fi
  echo "This script cannot be executed directly. Its execution should be triggered by either an \
Xcode build of the project or the main script, Deus.sh, located at the directory of the \
project."
  exit 1
}

assert_is_attached
