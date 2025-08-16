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

/// Base protocol to which ``ColoredParticle``s and colored antiparticles conform.
public protocol ColoredParticleLike<Color>: ParticleLike {
  /// The specific type of ``Color``.
  associatedtype Color: QuantumMechanics.Color

  /// Measured transformation under the SU(3) symmetry.
  var color: Color { get }
}

extension ColoredParticleLike {
  /// The default implementation of ``isPartiallyEqual(to:)``.
  ///
  /// - Parameter other: ``ColoredParticleLike`` to which this one will be compared.
  /// - Returns: `true` if the properties shared by these ``ColoredParticleLike`` values are equal;
  ///   otherwise, `false`.
  func _coloredParticleLikeIsPartiallyEqual(to other: some ParticleLike) -> Bool {
    guard let color = color as? AnyClass,
      let otherColor = (other as? any ColoredParticleLike)?.color as? AnyClass
    else { return _particleLikeIsPartiallyEqual(to: other) }
    return color === otherColor && _particleLikeIsPartiallyEqual(to: other)
  }
}

extension Anti: ColoredParticleLike
where Counterpart: ColoredParticle, Counterpart.Color: SingleColor {
  public var color: Anti<Counterpart.Color> { Anti<Counterpart.Color>(counterpart.color) }
}

/// Direct (in the case of a gluon ``Particle``) or indirect result of a localized excitation of the
/// ``Color`` field.
public protocol ColoredParticle<Color>: ColoredParticleLike, Particle {}

extension ColoredParticle where Self: ParticleLike {
  public func isPartiallyEqual(to other: some ParticleLike) -> Bool {
    guard let other = other as? any ColoredParticle else {
      return _particleLikeIsPartiallyEqual(to: other)
    }
    return _coloredParticleLikeIsPartiallyEqual(to: other)
  }
}
