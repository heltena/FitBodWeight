//
//  WorkoutTimeSerie.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import Charts
import SwiftUI

struct WorkoutTimeSerieView: View {
    var timeSerie: WorkoutTimeSerie
    
    var body: some View {
        VStack {
            WorkoutHeader(workout: timeSerie.lastWorkout ?? .invalidHeader(for: timeSerie.exerciseName))
            Chart(timeSerie.groupByDayValues(limiting: .month, value: -2)) { current in
                LineMark(
                    x: .value("Date of Workout", current.dateOfWorkout),
                    y: .value("1RM", current._1rm)
                )
                .lineStyle(.init(lineWidth: 2))
                .symbol {
                    Circle()
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxHeight: 240)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    WorkoutTimeSerieView(
        timeSerie: .preview)
}
