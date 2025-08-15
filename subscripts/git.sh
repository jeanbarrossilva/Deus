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

# /subscripts/git.sh
#
# Performs Git-related configuration, such as triggering actions (e.g., formatting files) before
# each commit.

set -e
sh "$(dirname "$0")"/_subscript.sh

hooks="$SRCROOT/.git/hooks"
pre_commit_hook="$hooks/pre-commit"

# Writes a hook which formats all *.swift files according to .swift-format, located at the directory
# of the project.
#
# --------------------------------------------------------------------------------------------------
#
# Parameters: none
# Returns:    void
write_pre_commit_hook() {
  touch "$pre_commit_hook"
  printf '#!/bin/bash' >> "$pre_commit_hook"
  printf "\n" >> "$pre_commit_hook"
  printf "$LICENSE_HEADER_SH" >> "$pre_commit_hook"
  printf "\n\n" >> "$pre_commit_hook"
  printf "swift-format -p -r -i $SRCROOT" >> "$pre_commit_hook"
  printf "\n" >> "$pre_commit_hook"
  printf "swift-format lint -p -r -s $SRCROOT" >> "$pre_commit_hook"
  printf "\n" >> "$pre_commit_hook"
  printf "git add ." >> "$pre_commit_hook"
  chmod +x "$pre_commit_hook"
}

rm -r "$hooks"
mkdir "$hooks"
write_pre_commit_hook
