//
//  Workout+Previews.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import Foundation

extension Workout {
    static let preview = Workout(dateOfWorkout: .now, exerciseName: "Example", reps: 10, weight: 120)
}

extension Array where Element == String {
    static var previewExerciseNames: Self {
        [ "Back Squat", "Barbell Bench Press" ]
    }
}

extension Array where Element == Workout {
    static var preview: Self {
        let dateFormatter = DateFormatter.forWorkout()
        
        return [
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 10, weight: 45),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 10, weight: 135),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 3, weight: 185),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 6, weight: 245),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 6, weight: 245),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 6, weight: 245),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 11 2020")!, exerciseName: "Back Squat", reps: 6, weight: 245),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 4, weight: 45),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 4, weight: 125),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 185),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 205),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 225),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 225),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 225),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 225),
            .init(dateOfWorkout: dateFormatter.date(from: "Oct 05 2020")!, exerciseName: "Barbell Bench Press", reps: 2, weight: 225),
        ]
    }
}

extension Dictionary where Key == String, Value == WorkoutTimeSerie {
    static var preview: Self {
        var workouts = [String: [Workout]]()
        for workout in [Workout].preview {
            workouts[workout.exerciseName, default: []].append(workout)
        }
        
        var result = [String: WorkoutTimeSerie]()
        for (exerciseName, workouts) in workouts {
            result[exerciseName] = WorkoutTimeSerie(
                exerciseName: exerciseName,
                workouts: workouts.sorted { $0.dateOfWorkout > $1.dateOfWorkout })
         }
        return result
    }
}
