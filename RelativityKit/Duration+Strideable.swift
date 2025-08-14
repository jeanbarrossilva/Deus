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

extension Duration: @retroactive Strideable {
  /// Total amount of attoseconds represented by this `Duration`, computed by summing the
  /// attoseconds component and the converted seconds one.
  var attoseconds: Int128 {
    .init(components.seconds) * Self.secondScaleAsInt128 + .init(components.attoseconds)
  }

  /// Amount of attoseconds within 1 s represented as an 128-bit integer.
  static let secondScaleAsInt128 = Int128(secondScaleAsDouble)

  /// Amount of attoseconds within 1 s represented as a `Double`.
  private static let secondScaleAsDouble = 1e18

  /// Minimum representable `Duration` of -2.923 × 10¹¹ a.
  private static let min = Self.init(secondsComponent: .min, attosecondsComponent: .min)

  /// Maximum representable `Duration` of 2.923 × 10¹¹ a.
  private static let max = Self.init(secondsComponent: .max, attosecondsComponent: .max)

  public func distance(to other: Duration) -> Int128 { other.attoseconds - attoseconds }

  public func advanced(by n: Int128) -> Duration {
    guard n != 0 else { return self }
    let advancedAttoseconds = attoseconds + n
    let advancedSeconds = Int128(Double(advancedAttoseconds) / Self.secondScaleAsDouble)
    let advancedAttosecondsComponent = advancedAttoseconds % Self.secondScaleAsInt128
    guard let advancedAttosecondsComponent = Int64(exactly: advancedAttosecondsComponent) else {
      // The attoseconds component overflowing the capacity of a 64-bit integer does not necessarily
      // result in us having to return the minimum or maximum duration, since we can still fall back
      // to representing most of the duration in seconds — with 1 s being 1e-18 attoseconds and,
      // consequently, requiring less bits.
      //
      // Below, the attoseconds component is clamped (set as either Int64.min or Int64.max), while
      // the seconds component is defined as that clamped amount of attoseconds, converted into
      // seconds, subtracted from the advanced seconds.
      let clampedAdvancedAttosecondsComponent = Int64(clamping: advancedAttosecondsComponent)
      let clampedAdvancedSecondsComponent = Int64(
        clamping: advancedSeconds - .init(clampedAdvancedAttosecondsComponent)
          / Self.secondScaleAsInt128
      )

      // If any of these guards fail, there was an overflow even when trying to represent most of
      // the duration in seconds. Not much else can be done here other than clamping to the minimum
      // or maximum duration.
      guard clampedAdvancedSecondsComponent > .min else { return .min }
      guard clampedAdvancedSecondsComponent < .max else { return .max }

      return .init(
        secondsComponent: clampedAdvancedSecondsComponent,
        attosecondsComponent: clampedAdvancedAttosecondsComponent
      )
    }
    guard let advancedSecondsComponent = Int64(exactly: advancedSeconds) else {
      // Now, the same as above is done for the seconds component when it cannot be represented in
      // only 64 bits. Some of it will be converted into attoseconds and added to the advanced
      // attoseconds, resorting to returning the minimum or maximum duration in case it still
      // overflows.
      //
      // This is way less significant than the previous case, given that ⌊log₂(1e18)⌋ + 1 (60) bits
      // are required for representing as few as 1 s in attoseconds.
      let clampedAdvancedSecondsComponent = Int64(clamping: advancedSeconds)
      let remainingSecondsComponent = advancedSeconds - .init(clampedAdvancedSecondsComponent)
      let clampedAdvancedAttosecondsComponent = Int64(
        clamping: Int128(advancedAttosecondsComponent) + remainingSecondsComponent
          * Self.secondScaleAsInt128
      )
      guard clampedAdvancedSecondsComponent > .min || clampedAdvancedAttosecondsComponent > .min
      else { return .min }
      guard clampedAdvancedSecondsComponent < .max || clampedAdvancedAttosecondsComponent < .max
      else { return .max }
      return .init(
        secondsComponent: clampedAdvancedSecondsComponent,
        attosecondsComponent: clampedAdvancedAttosecondsComponent
      )
    }
    return .init(
      secondsComponent: advancedSecondsComponent,
      attosecondsComponent: advancedAttosecondsComponent
    )
  }
}
