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

struct AnyQuarkLikeTests {
  @Test(arguments: [
    AnyQuarkLike(UpQuark(color: red)), .init(Anti(UpQuark(color: red))),
    .init(UpQuark(color: green)), .init(Anti(UpQuark(color: green))), .init(UpQuark(color: blue)),
    .init(Anti(UpQuark(color: blue))), .init(DownQuark(color: red)),
    .init(Anti(DownQuark(color: red))), .init(DownQuark(color: green)),
    .init(Anti(DownQuark(color: green))), .init(DownQuark(color: blue)),
    .init(Anti(DownQuark(color: blue))), .init(StrangeQuark(color: red)),
    .init(Anti(StrangeQuark(color: red))), .init(StrangeQuark(color: green)),
    .init(Anti(StrangeQuark(color: green))), .init(StrangeQuark(color: blue)),
    .init(Anti(StrangeQuark(color: blue))), .init(CharmQuark(color: red)),
    .init(Anti(CharmQuark(color: red))), .init(CharmQuark(color: green)),
    .init(Anti(CharmQuark(color: green))), .init(CharmQuark(color: blue)),
    .init(Anti(CharmQuark(color: blue))), .init(BottomQuark(color: red)),
    .init(Anti(BottomQuark(color: red))), .init(BottomQuark(color: green)),
    .init(Anti(BottomQuark(color: green))), .init(BottomQuark(color: blue)),
    .init(Anti(BottomQuark(color: blue))), .init(TopQuark(color: red)),
    .init(Anti(TopQuark(color: red))), .init(TopQuark(color: green)),
    .init(Anti(TopQuark(color: green))), .init(TopQuark(color: blue)),
    .init(Anti(TopQuark(color: blue)))
  ])
  func allKnownQuarksAndAntiquarksAreIncludedInDiscretion(_ quarkLike: AnyQuarkLike) {
    #expect(
      AnyQuarkLike.discretion.contains(where: { discreteQuarkLike in discreteQuarkLike == quarkLike
        })
    )
  }
}
