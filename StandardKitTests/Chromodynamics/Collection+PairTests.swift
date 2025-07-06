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

@Suite("Collection+Pair tests") struct CollectionPairTests {
  @Suite("Pairing") struct PairingTests {
    @Test func pairingOnAnEmptyArrayReturnsAnEmptyArray() {
      #expect([Int]().paired(to: { n in n }) == [])
    }

    @Test func pairsElementsToThoseOfAPopulatedArray() {
      #expect([2, 4].paired(to: { n in n + 1 }) == [2, 3, 4, 5])
    }
  }
}
