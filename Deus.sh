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

# ./Deus.sh
#
# Performs global configurations and exports values for all subscripts within the project (located
# at ./subscripts); such subscripts are, then, executed by this Deus.sh script.
#
# This script is executed automatically before each time the project is built. Therefore, normally,
# there is no reason for executing it manually — although doing so would not result in any negative
# side effects.

# Exports an environment variable, SRCROOT, containing the directory of the project. Such variable
# already gets exported by Xcode by default; it is only actually exported by this function in case
# this script, for some reason, is being run directly.
#
# --------------------------------------------------------------------------------------------------
#
# - Parameters: none
# - Returns:    void
export_srcroot() {
  if [[ -z "$SRCROOT" ]]; then
    export SRCROOT="$(dirname "$0")"
  fi
}

# Exports variations of the license header which must be present in each user-generated file of
# Deus, according to the file into which it is intended to be written. Implies that the maximum
# length of a column is of 100 characters, formatting the headers accordingly.
#
# +-------------+----------------------+
# |    File     |       Variable       |
# +-------------+----------------------+
# | .sh         | LICENSE_HEADER_SH    |
# +-------------+----------------------+
# | .swift      | LICENSE_HEADER_SWIFT |
# +-------------+----------------------+
#
# --------------------------------------------------------------------------------------------------
#
# - Parameters: none
# - Returns:    void
export_license_headers() {
  export LICENSE_HEADER_SH=$(cat << EOF
# ===--------------------------------------------------------------------------------------------===
# Copyright © $(date +%Y) Deus
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
EOF)
  export LICENSE_HEADER_SWIFT=$(cat << EOF
// ===-------------------------------------------------------------------------------------------===
// Copyright © $(date +%Y) Deus
//
// This file is part of the Deus open-source project.
//
// This program is free software: you can redistribute it and/or modify it under the terms of the
// GNU General Public License as published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
// even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with this program. If
// not, see https://www.gnu.org/licenses.
// ===-------------------------------------------------------------------------------------------===
EOF)
}

set -e
export_srcroot
export_license_headers

sh "$SRCROOT"/subscripts/git.sh
sh "$SRCROOT"/subscripts/gyb.sh
