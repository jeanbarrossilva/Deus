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

@testable import QuantumMechanics

struct AnySingleColorLikeTests {
  @Test(arguments: [
    AnySingleColorLike(red), .init(Anti(red)), .init(green), .init(Anti(green)), .init(blue),
    .init(Anti(blue))
  ])
  func allKnownColorsAndAnticolorsAreIncludedInDiscretion(_ colorLike: AnySingleColorLike) {
    #expect(
      AnySingleColorLike.discretion.contains(where: { discreteColorLike in
        discreteColorLike == colorLike
      })
    )
  }

  @Test(arguments: AnySingleColorLike.discretion)
  func isBaseColorLike(_ colorLike: AnySingleColorLike) {
    if colorLike.base is Red {
      #expect(colorLike.is(Red.self))
    } else if colorLike.base is Anti<Red> {
      #expect(colorLike.is(Anti<Red>.self))
    } else if colorLike.base is Green {
      #expect(colorLike.is(Green.self))
    } else if colorLike.base is Anti<Green> {
      #expect(colorLike.is(Anti<Green>.self))
    } else if colorLike.base is Blue {
      #expect(colorLike.is(Blue.self))
    } else if colorLike.base is Anti<Blue> {
      #expect(colorLike.is(Anti<Blue>.self))
    }
  }
}
