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

/// Amount of force experienced by matter in an electromagnetic field.
public enum Charge: Measurement {
  public static var zero = Charge.make(value: 0)
  public static let backingUnitSymbol = "e"

  public var symbol: String {
    switch self {
    case .elementary(_): Self.backingUnitSymbol
    }
  }

  public var value: Double {
    switch self {
    case .elementary(let value): value
    }
  }

  /// Amount in elementary charge (*e*). *e* is a fundamental constant as per the SI, equating
  /// 1.602176634 × 10⁻¹⁹ C and representing the least amount of ``Charge`` which can exist
  /// unconfined in the universe.
  case elementary(Double)

  public static func make(value: Double) -> Charge { .elementary(value) }
}
