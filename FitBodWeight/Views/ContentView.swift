//
//  ContentView.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import SwiftUI

struct ContentView: View {
    var exerciseNames: [String]
    var workouts: [String: WorkoutTimeSerie]
    
    func workoutHeader(for exerciseName: String) -> Workout {
        workouts[exerciseName]?.lastWorkout ?? .invalidHeader(for: exerciseName)
    }
    
    var body: some View {
        NavigationView {
            List(exerciseNames, id: \.self) { exerciseName in
                Group {
                    if let timeSerie = workouts[exerciseName] {
                        NavigationLink {
                            WorkoutTimeSerieView(timeSerie: timeSerie)
                        } label: {
                            WorkoutHeader(workout: workoutHeader(for: exerciseName))
                        }
                    } else {
                        WorkoutHeader(workout: workoutHeader(for: exerciseName))
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.inset)
            .navigationTitle("") // Ugly, but needed by spec
        }
    }
}

#Preview {
    ContentView(
        exerciseNames: .previewExerciseNames,
        workouts: .preview)
}
