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

@testable import RelativityKit

actor ClockTests {
  private var clock = Clock()

  init() async { await clock.start() }

  @Test
  func virtualModeIsDefaultOne() async throws {
    try await Task.sleep(for: .microseconds(2))
    #expect(await clock.elapsedTime == .zero)
  }

  @Test
  func timeIsNotElapsedAutomaticallyOnWallModeWhenNotStarted() async throws {
    await clock.reset()
    await clock.setMode(.wall)
    try await Task.sleep(for: .microseconds(2))
    #expect(await clock.elapsedTime == .zero)
    await clock.reset()
  }

  @Test
  func timeIsElapsedAutomaticallyOnWallModeUponStart() async throws {
    await clock.setMode(.wall)
    try await Task.sleep(for: .microseconds(2))
    #expect(await clock.elapsedTime > .zero)
    await clock.reset()
  }

  @Test
  func elapsedTimeIncreasesPerSubtick() async throws {
    await clock.advanceTime(by: .microseconds(2), spacing: .linear)
    #expect(await clock.elapsedTime == .microseconds(2))
    await clock.reset()
  }

  @Test
  func ignoresTimeAdvancementsWhenNotTicking() async throws {
    await clock.reset()
    await clock.advanceTime(by: .microseconds(2), spacing: .linear)
    await clock.start()
    #expect(await clock.elapsedTime == .zero)
    await clock.reset()
  }

  @Test(arguments: [
    [CountingTimeLapseListener()],
    [CountingTimeLapseListener](count: 2) { _ in CountingTimeLapseListener() }
  ])
  func adds(timeLapseListeners: [CountingTimeLapseListener]) async throws {
    for listener in timeLapseListeners { let _ = await clock.addTimeLapseListener(listener) }
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    for listener in timeLapseListeners { #expect(listener.count == 3) }
    await clock.reset()
  }

  @Test
  func startTimePassedIntoTimeLapseListenerEqualsToThatElapsedUponAdvancementRequest() async throws
  {
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    let _ = await clock.addTimeLapseListener { _, start, _, _ in #expect(start == .milliseconds(2))
    }
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    await clock.reset()
  }

  @Test
  func previousTimeIsNilWhenTimeLapseIsNotifiedToListenerAfterClockIsJustStarted() async throws {
    let listener = CountingTimeLapseListener()
    let _ = await clock.addTimeLapseListener(listener)
    let _ = await clock.addTimeLapseListener { _, _, previous, _ in
      guard listener.count == 0 else { return }
      #expect(previous == nil)
    }
    await clock.advanceTime(by: .milliseconds(1), spacing: .linear)
    await clock.reset()
  }

  @Test
  func previousTimePassedIntoTimeLapseListenerEqualsToLastElapsedOneAtPause() async throws {
    let listener = CountingTimeLapseListener()
    let _ = await clock.addTimeLapseListener(listener)
    let _ = await clock.addTimeLapseListener { clock, _, previous, _ in
      switch listener.count {
      case 0, 1, 2, 3: return
      case 4: #expect(previous == .milliseconds(3))
      case 5: #expect(previous == .milliseconds(4))
      default:
        let current = await clock.elapsedTime
        fatalError("Unexpected time lapse to \(current).")
      }
    }
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    await clock.reset()
    await clock.advanceTime(by: .milliseconds(1), spacing: .linear)
    await clock.reset()
  }

  @Test
  func previousTimePassedIntoTimeLapseListenerIsOneMicrosecondLessThanCurrentOne() async throws {
    let _ = await clock.addTimeLapseListener { clock, _, previous, _ in
      guard let previous else { return }
      #expect(await previous == clock.elapsedTime - .milliseconds(1))
    }
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    await clock.reset()
  }

  @Test
  func endTimePassedIntoTimeLapseListenerIsEqualToThatToWhichTheTimeIsAdvancedToward() async throws
  {
    let _ = await clock.addTimeLapseListener { _, _, _, end in #expect(end == .milliseconds(2)) }
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    await clock.reset()
  }

  @Test
  func advancesTimeExtremely() async throws {
    let listener = CountingTimeLapseListener()
    let _ = await Task { await clock.addTimeLapseListener(listener) }.value
    let _ = await clock.addTimeLapseListener { clock, _, _, _ in
      let current = await clock.elapsedTime
      switch listener.count {
      case 1: #expect(current == .zero)
      case 2: #expect(current == .milliseconds(8))
      default: fatalError("Unexpected time lapse to \(current).")
      }
    }
    await clock.advanceTime(by: .milliseconds(8), spacing: .extreme)
    await clock.reset()
  }

  @Test
  func advancesTimeLinearly() async throws {
    let listener = CountingTimeLapseListener()
    let _ = await Task { await clock.addTimeLapseListener(listener) }.value
    let _ = await clock.addTimeLapseListener { clock, _, _, _ in
      #expect(await clock.elapsedTime == .milliseconds(listener.count - 1))
    }
    await clock.advanceTime(by: .milliseconds(8), spacing: .linear)
    await clock.reset()
  }

  @Test
  func advancesTimeEasedly() async throws {
    let listener = CountingTimeLapseListener()
    let _ = await Task { await clock.addTimeLapseListener(listener) }.value
    let _ = await clock.addTimeLapseListener { clock, _, _, _ in
      let current = await clock.elapsedTime
      switch listener.count {
      case 1: #expect(current == .zero)
      case 2: #expect(current == .milliseconds(56))
      case 3: #expect(current == .milliseconds(112))
      case 4: #expect(current == .milliseconds(180))
      case 5: #expect(current == .milliseconds(272))
      case 6: #expect(current == .milliseconds(400))
      case 7: #expect(current == .milliseconds(576))
      case 8: #expect(current == .milliseconds(812))
      case 9: #expect(current == .milliseconds(1_120))
      case 10: #expect(current == .milliseconds(1_512))
      case 11: #expect(current == .seconds(2))
      default: fatalError("Unexpected time lapse to \(current).")
      }
    }
    await clock.advanceTime(by: .seconds(2), spacing: .eased)
    await clock.reset()
  }

  @Test(arguments: [
    [CountingTimeLapseListener()],
    [CountingTimeLapseListener](count: 2) { _ in CountingTimeLapseListener() }
  ])
  func removes(timeLapseListeners: [CountingTimeLapseListener]) async throws {
    let ids = await Task {
      await timeLapseListeners.map { listener in
        await Task { await clock.addTimeLapseListener(listener) }.value
      }
    }.value
    for id in ids { await clock.removeTimeLapseListener(identifiedAs: id) }
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    for listener in timeLapseListeners { #expect(listener.count == 0) }
    await clock.reset()
  }

  @Test
  func resets() async throws {
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    await clock.reset()
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    await clock.start()
    #expect(await clock.elapsedTime == .zero)
  }

  @Test(arguments: [
    [CountingTimeLapseListener()],
    [CountingTimeLapseListener](count: 2) { _ in CountingTimeLapseListener() }
  ])
  func removesUponReset(timeLapseListeners: [CountingTimeLapseListener]) async throws {
    for listener in timeLapseListeners { let _ = await clock.addTimeLapseListener(listener) }
    await clock.reset()
    await clock.start()
    await clock.advanceTime(by: .milliseconds(2), spacing: .linear)
    for listener in timeLapseListeners { #expect(listener.count == 0) }
  }
}
