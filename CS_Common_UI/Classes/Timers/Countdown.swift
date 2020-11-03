//
//  Countdown.swift
//  FitGoal
//
//  Created by Christian Slanzi on 23.03.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//
import Foundation

public class Countdown {
    
    // MARK: Private Properties

    private let startTime: Double
    private let step: Double
    private var timer: Timer?
    
    //The time when counting was started
    private(set) var from: Date?
    //The time when counting was stopped
    private(set) var toTime: Date?

    // The time when user pause timer last one
    private var timeIntervalTimelapsFrom: TimeInterval?
    // The total time before user paused timer
    private var timerSavedTime: TimeInterval = 0

    public typealias TimeUpdated = (_ time: Double) -> Void
    let timeUpdated: TimeUpdated

    // MARK: Public Properties
    
    var isPaused: Bool {
        return timer == nil
    }
    
    // MARK: Initialization
    
    public init(startTime: Double = 60.0, step: Double = 1.0, timeUpdated: @escaping TimeUpdated) {
        self.startTime = startTime
        self.step = step
        self.timeUpdated = timeUpdated
    }
    
    deinit {
        print("⏱ Countdown successfully deinited")
        deinitTimer()
    }
    
    // MARK: Timer actions

    public func toggle() {
        guard timer != nil else {
            initTimer()
            return
        }
        deinitTimer()
    }
    
    public func stop() {
        deinitTimer()
        from = nil
        toTime = nil
        timerSavedTime = 0
        timeUpdated(0)
    }
    
    private func initTimer() {
        let action: (Timer) -> Void = { [weak self] timer in
            guard let strongSelf = self else {
                return
            }
            let toTime = Date().timeIntervalSince1970
            let timeIntervalFrom = strongSelf.timeIntervalTimelapsFrom ?? toTime
            let time = strongSelf.startTime - (strongSelf.timerSavedTime + (toTime - timeIntervalFrom))
            strongSelf.timeUpdated(round(time))
            if time <= 0 {
                strongSelf.stop()
            }
        }
        if from == nil {
            from = Date()
        }
        if timeIntervalTimelapsFrom == nil {
            timeIntervalTimelapsFrom = Date().timeIntervalSince1970
        }
        timeUpdated(round(startTime))
        timer = Timer.scheduledTimer(withTimeInterval: step,
                                     repeats: true, block: action)
    }
    
    private func deinitTimer() {
        //Saving last timelaps
        if let timeIntervalTimelapsFrom = timeIntervalTimelapsFrom {
            let toTime = Date().timeIntervalSince1970
            timerSavedTime += toTime - timeIntervalTimelapsFrom
        }
        //Invalidating
        timer?.invalidate()
        timer = nil
        timeIntervalTimelapsFrom = nil
    }
}
