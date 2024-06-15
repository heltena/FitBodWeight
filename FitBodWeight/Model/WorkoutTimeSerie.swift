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
    var max1rmWorkout: Workout? { workouts.max { $0._1rm < $1._1rm } }

    func groupByDayValues() -> [WorkoutDayPoint] {
        groupByDayValues(minDate: nil)
    }
    
    func groupByDayValues(limiting component: Calendar.Component, value: Int) -> [WorkoutDayPoint] {
        guard
            let max1rmWorkout,
            let minDate = Calendar.current.date(byAdding: component, value: value, to: max1rmWorkout.dateOfWorkout)
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
            let _1rm = workouts.map { $0._1rm }.max() ?? 0
            result.append(WorkoutDayPoint(dateOfWorkout: dateOfWorkout, _1rm: _1rm))
        }
        return result.sorted { $0.dateOfWorkout < $1.dateOfWorkout }
    }

}
