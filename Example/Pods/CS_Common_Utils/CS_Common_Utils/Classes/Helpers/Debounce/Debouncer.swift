//
//  Debouncer.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 22.10.20.
//

import Foundation

/// Throttle action, allow action to be performed after some delay
final class Debouncer {
  private let delay: TimeInterval
  private var workItem: DispatchWorkItem?

  init(delay: TimeInterval) {
    self.delay = delay
  }

  /// Trigger the action after some delay
  func schedule(action: @escaping () -> Void) {
    workItem?.cancel()
    workItem = DispatchWorkItem(block: action)
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: workItem!)
  }
}
