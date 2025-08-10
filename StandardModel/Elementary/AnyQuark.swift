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

import Foundation

/// ``QuarkLike`` whose flavor information has been erased.
public struct AnyQuarkLike: Discrete, QuarkLike {
  /// ``Quark`` based on which this one was initialized.
  let base: any QuarkLike

  public static var discretion: [Self] = AnyQuark.discretion.flatMap { quark in
    [.init(quark), .init(Anti(quark))]
  }

  public let spin: Spin
  public let charge: Measurement<UnitElectricCharge>
  public let symbol: String
  public let color: AnySingleColorLike

  public init(_ base: any QuarkLike) {
    if let base = base as? Self {
      self = base
    } else {
      self.base = base
      spin = base.spin
      charge = base.charge
      symbol = base.symbol
      color = .init(base.color)
    }
  }

  public func getMass(
    approximatedBy approximator: Approximator<Measurement<UnitMass>>
  ) -> Measurement<UnitMass> { base.getMass(approximatedBy: approximator) }
}

/// ``Quark`` whose flavor information has been erased.
public struct AnyQuark: Discrete, Quark {
  /// ``Quark`` based on which this one was initialized.
  let base: any QuarkLike

  public static var discretion: [Self] = AnySingleColor.discretion.flatMap { color in
    [
      .init(UpQuark(color: color)), .init(DownQuark(color: color)), .init(CharmQuark(color: color)),
      .init(StrangeQuark(color: color)), .init(BottomQuark(color: color)),
      .init(TopQuark(color: color))
    ]
  }.sorted(by: <)

  public let spin: Spin
  public let charge: Measurement<UnitElectricCharge>
  public let symbol: String
  public let color: AnySingleColor

  public init(_ base: any Quark) {
    if let base = base as? Self {
      self = base
    } else {
      self.base = base
      spin = base.spin
      charge = base.charge
      symbol = base.symbol
      color = .init(base.color)
    }
  }

  public func getMass(
    approximatedBy approximator: Approximator<Measurement<UnitMass>>
  ) -> Measurement<UnitMass> { base.getMass(approximatedBy: approximator) }
}
