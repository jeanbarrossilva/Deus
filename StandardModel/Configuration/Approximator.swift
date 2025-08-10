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

/// Producer of a value which is an approximation to the expected one, based on the derired level of
/// precision. Allows for accounting margins of error for simulating high-fidelity behaviors with
/// consistency, maintaining the criteria of such approximations.
public enum Approximator<Approximation: Comparable> {
  /// Always produces the exact base value when calculating an approximation for it, ignoring
  /// statistical and systematic uncertainties.
  case base

  /// Produces an approximation to the given base value.
  ///
  /// - Parameters:
  ///   - base: Central value based on which the approximation is to be calculated.
  ///   - statisticalUncertainty: Margin of error resulted from experiments, which considers
  ///     variation stemming from the behavior of the subject under test. The actual value may
  ///     fluctuate positively or negatively towards or away from this value.
  ///   - systematicUncertainty: Margin of error from the limitations of the equipment used in the
  ///     experiments or the experiments themselves, with the latter being (probably) because of
  ///     lack of sufficient knowledge regarding the subject under test or the experimentation
  ///     itself.
  func approximate(
    _ base: Approximation,
    _ statisticalUncertainty: Approximation,
    _ systematicUncertainty: Approximation
  ) -> Approximation {
    switch self {
    case .base: base
    }
  }
}
