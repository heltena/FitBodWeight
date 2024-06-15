//
//  FitBodWeightApp.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import SwiftUI

@main
struct FitBodWeightApp: App {
    @State var manager = WorkoutManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch manager.data {
                case .success(let workouts):
                    ContentView(exerciseNames: workouts.keys.sorted(), workouts: workouts)
                case .failure(let error):
                    ErrorView(error: error)
                }
            }
            .tint(.primary)
        }
    }
}
