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

# Configures the Python virtual environment (venv).
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip

# Installs packages required by some of the .gyb files into the venv.
pip install inflect

# Generates the boilerplate.
find . -name '*.gyb' \
  | while read file; do ./gyb.py --line-directive '' -o "${file%.gyb}.swift" "$file"; done

# Deconfigures the venv.
deactivate
