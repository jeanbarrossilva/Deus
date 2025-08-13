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

/// An immutable container into which elements are laid out contiguously.
public struct InlineArray<Element> {
  /// Contiguous memory in which the elements are allocated.
  private var buffer: UnsafeMutableBufferPointer<Element>?
}

extension InlineArray: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    elements.withUnsafeBytes { body in buffer = .init(mutating: body.bindMemory(to: Element.self)) }
  }
}

extension InlineArray: Sequence {}

extension InlineArray: RandomAccessCollection {
  public var startIndex: Int { buffer!.startIndex }
  public var endIndex: Int { buffer!.endIndex }

  public subscript(position: Int) -> Element { borrowing _read { yield buffer![position] } }
}
