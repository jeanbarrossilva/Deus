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

import AppKit
import RealityKit
import StandardModel
import Testing

@testable import ObservationKit

@Suite("Entity+QuarkLike tests")
struct EntityQuarkLikeTests {
  @Test(arguments: AnyQuarkLike.discretion)
  func entityIsColored(witColorOf quark: AnyQuarkLike) {
    guard let entity = Entity(quark) else { fatalError("Entity initialization has failed.") }
    let components = entity.components
    #expect(components.count == 1)
    guard let singleComponent = components[components.startIndex] as? ModelComponent else {
      fatalError("Single component of entity is not a ModelComponent.")
    }
    let materials = singleComponent.materials
    #expect(materials.count == 1)
    guard let singleMaterial = materials[materials.startIndex] as? SimpleMaterial else {
      fatalError("Single material of entity is not a simple one.")
    }
    #expect(singleMaterial.color.tint == NSColor(quark.color))
  }
}
