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

# /subscripts/gyb.sh
#
# Generates boilerplate from *.gyb files.

set -e
sh "$(dirname "$0")"/_subscript.sh

# Configures the Python virtual environment by activating it, upgrading the package manager to the
# latest version and installing any libraries required by the *.gyb files.
#
# -------------------------------------------------------------------------------------------------
#
# Parameters: none
# Returns:    void
activate() {
  python3 -m venv .venv
  source "$SRCROOT"/.venv/bin/activate
  pip install --upgrade pip
  pip install inflect
}

# Generates *.swift files based on each *.gyb file present in the project.
#
# -------------------------------------------------------------------------------------------------
#
# Parameters: none
# Returns:    void
generate_boilerplate() {
  find "$SRCROOT" -name '*.gyb' | while read file; do
    "$SRCROOT"/subscripts/gyb.py --line-directive '' -o "${file%.gyb}.swift" "$file"
  done
}

activate
generate_boilerplate
deactivate
