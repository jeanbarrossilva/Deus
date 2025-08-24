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

/// An immutable array of fixed size.
public final class FixedArray<Element>: ExpressibleByArrayLiteral, Sequence {
  /// Pointer to the first element allocated into the contiguous memory.
  private var pointer: UnsafeMutablePointer<Element>

  public let startIndex: Int
  public let endIndex: Int

  public required init(arrayLiteral elements: Element...) {
    pointer = .allocate(capacity: elements.count)
    for element in elements {
      pointer.initialize(to: element)
      pointer = pointer.successor()
    }
    pointer = pointer.advanced(by: -elements.count)
    startIndex = elements.startIndex
    endIndex = elements.endIndex
  }

  deinit { pointer.deinitialize(count: count) }
}

extension FixedArray: RandomAccessCollection {
  public subscript(position: Int) -> Element { pointer[position] }
}

extension FixedArray: @unchecked Sendable where Element: Sendable {}
