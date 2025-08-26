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

struct AnyQuarkTests {
  @Test(arguments: [
    AnyQuark(UpQuark(colorLike: red)), .init(UpQuark(colorLike: green)),
    .init(UpQuark(colorLike: blue)), .init(DownQuark(colorLike: red)),
    .init(DownQuark(colorLike: green)), .init(DownQuark(colorLike: blue)),
    .init(StrangeQuark(colorLike: red)), .init(StrangeQuark(colorLike: green)),
    .init(StrangeQuark(colorLike: blue)), .init(CharmQuark(colorLike: red)),
    .init(CharmQuark(colorLike: green)), .init(CharmQuark(colorLike: blue)),
    .init(BottomQuark(colorLike: red)), .init(BottomQuark(colorLike: green)),
    .init(BottomQuark(colorLike: blue)), .init(TopQuark(colorLike: red)),
    .init(TopQuark(colorLike: green)), .init(TopQuark(colorLike: blue))
  ])
  func allKnownQuarksAreIncludedInDiscretion(_ quark: AnyQuark) {
    #expect(AnyQuark.discretion.contains(where: { discreteQuark in discreteQuark == quark }))
  }
}
