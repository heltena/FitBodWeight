//
//  WorkoutHeader.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import SwiftUI

struct WorkoutHeader: View {
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(workout.exerciseName)
                Spacer()
                Text(workout._1rm, format: .number)
            }
            .font(.title)
            Text("One Rep Max • lbs")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
    }
}

#Preview {
    WorkoutHeader(workout: .preview)
}
