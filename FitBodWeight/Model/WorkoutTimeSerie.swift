//
//  WorkoutTimeSerie.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import Foundation

struct WorkoutDayPoint: Identifiable {
    var id = UUID()
    var dateOfWorkout: Date
    var _1rm: Int
}

struct WorkoutTimeSerie {
    var exerciseName: String
    var workouts: [Workout]
    var lastWorkout: Workout? { workouts.first }

    func groupByDayValues() -> [WorkoutDayPoint] {
        groupByDayValues(minDate: nil)
    }
    
    func groupByDayValues(limiting component: Calendar.Component, value: Int) -> [WorkoutDayPoint] {
        guard
            let lastWorkout,
            let minDate = Calendar.current.date(byAdding: component, value: value, to: lastWorkout.dateOfWorkout)
        else {
            return []
        }
        
        return groupByDayValues(minDate: minDate)
    }
    
    private func groupByDayValues(minDate: Date?) -> [WorkoutDayPoint] {
        let values: [Workout]
        if let minDate {
            values = workouts.filter { $0.dateOfWorkout >= minDate }
        } else {
            values = workouts
        }
        
        let groupedByDay = Dictionary(grouping: values) { $0.dateOfWorkout }
        var result = [WorkoutDayPoint]()
        for (dateOfWorkout, workouts) in groupedByDay {
            if workouts.isEmpty {
                continue
            }
            // Average
            let _1rm = workouts.map { $0._1rm }.reduce(0, +) / workouts.count
            result.append(WorkoutDayPoint(dateOfWorkout: dateOfWorkout, _1rm: _1rm))
        }
        return result.sorted { $0.dateOfWorkout < $1.dateOfWorkout }
    }

}
