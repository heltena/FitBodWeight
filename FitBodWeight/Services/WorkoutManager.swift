//
//  WorkoutManager.swift
//  FitBodWeight
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import Foundation

enum WorkoutError: Error {
    case read(String)
    case workout(String, lineno: Int)
    case other
}

struct WorkoutManager {
    let data: Result<[String: WorkoutTimeSerie], WorkoutError>
    
    init() {
        let url = Bundle.main.url(forResource: "workoutData", withExtension: "txt")
        self.init(url: url)
    }
    
    fileprivate init(url: URL?) {
        do {
            if let url {
                let workouts = try Self.readWorkoutResource(url: url)
                data = .success(workouts)
            } else {
                data = .failure(.read("Cannot find the data file"))
            }
        } catch let error as WorkoutError {
            data = .failure(error)
        } catch {
            data = .failure(WorkoutError.other)
        }
    }
    
    private static func readWorkoutResource(url: URL) throws -> [String: WorkoutTimeSerie] {
        guard
            let content = try? String(contentsOf: url, encoding: .utf8)
        else {
            throw WorkoutError.read("Cannot read the workout data file")
        }
        
        let dateFormatter = DateFormatter.forWorkout()
        
        var workouts: [String: [Workout]] = [:]
        for (lineno, line) in content.components(separatedBy: .newlines).enumerated() {
            guard !line.isEmpty else { continue }
            let components = line.components(separatedBy: ",")
            guard 
                components.count == 4
            else {
                throw WorkoutError.workout("Invalid component counts", lineno: lineno + 1)
            }
            
            guard let dateOfWorkout = dateFormatter.date(from: components[0]) else {
                throw WorkoutError.workout("Invalid dateOfWorkout", lineno: lineno + 1)
            }

            let exerciseName = components[1]
            

            guard let reps = Int(components[2]) else {
                throw WorkoutError.workout("Invalid reps", lineno: lineno + 1)
            }
            
            guard let weight = Int(components[3]) else {
                throw WorkoutError.workout("Invalid weight", lineno: lineno + 1)
            }
            
            let workout = Workout(dateOfWorkout: dateOfWorkout, exerciseName: exerciseName, reps: reps, weight: weight)
            workouts[exerciseName, default: []].append(workout)
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

extension WorkoutManager {
    static func test(url: URL?) -> Self {
        .init(url: url)
    }
}
