//
//  ErrorView.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import SwiftUI

struct ErrorView: View {
    let error: WorkoutError
    
    var body: some View {
        HStack {
            Image(systemName: "xmark")
                .foregroundColor(.red)
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text("Error")
                    .bold()
                switch error {
                case .read(let string):
                    Text(string)
                case .workout(let string, let lineno):
                    Text("Workout error: \(string) at line: \(lineno)")
                case .other:
                    Text("Unknown error")
                }
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    VStack {
        ErrorView(error: .read("Generic error"))
        ErrorView(error: .workout("date of workout", lineno: 12))
        ErrorView(error: .other)
    }
}
