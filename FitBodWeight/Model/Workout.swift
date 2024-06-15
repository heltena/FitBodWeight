//
//  Workout.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import Foundation

struct Workout {
    let dateOfWorkout: Date
    let exerciseName: String
    let reps: Int
    let weight: Int
    
    var _1rm: Int { Int(Float(weight) * (36 / (37 - Float(reps)))) }
}

extension Workout {
    static func invalidHeader(for exerciseName: String) -> Workout {
        .init(dateOfWorkout: .now, exerciseName: exerciseName, reps: 0, weight: 0)
    }
}
