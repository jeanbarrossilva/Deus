// ===-------------------------------------------------------------------------------------------===
// Copyright © 2025 Deus
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

import Testing

@testable import StandardModel

struct AnySingleColorTests {
  @Test(arguments: [AnySingleColor(red), .init(green), .init(blue)])
  func allKnownColorsAreIncludedInDiscretion(_ singleColor: AnySingleColor) {
    #expect(
      AnySingleColor.discretion.contains(where: { discreteSingleColor in
        discreteSingleColor == singleColor
      })
    )
  }

  @Test(arguments: AnySingleColor.discretion)
  func isBaseColor(_ color: AnySingleColor) {
    if color.base is Red {
      #expect(color.is(Red.self))
    } else if color.base is Green {
      #expect(color.is(Green.self))
    } else if color.base is Blue {
      #expect(color.is(Blue.self))
    }
  }
}
