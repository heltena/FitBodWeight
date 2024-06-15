//
//  FitBodWeightTests.swift
//  FitBodWeightTests
//
//  Created by Heliodoro Tejedor Navarro on 15/6/24.
//

import XCTest
@testable import FitBodWeight

final class FitBodWeightTests: XCTestCase {
    func testReader() throws {
        let manager = WorkoutManager()
        switch manager.data {
        case .success(let workouts):
            let counts = [
                "Deadlift": 183,
                "Back Squat": 210,
                "Barbell Bench Press": 189
            ]
            
            XCTAssert(workouts.count == counts.count, "Invalid workouts count")
            for (exerciseName, count) in counts {
                XCTAssert(workouts[exerciseName]?.workouts.count == count, "Invalid '\(exerciseName)' counts")
            }
            
        case .failure(_):
            XCTFail("It should read the workout data")
        }
    }
    
    func testWrongFile() throws {
        let x = Bundle(for: FitBodWeightTests.self)
        let url = x.url(forResource: "workoutDoesNotExist", withExtension: "txt")
        let manager = WorkoutManager.test(url: url)
        switch manager.data {
        case .success:
            XCTFail("It should fail!")
        case .failure(let error):
            switch error {
            case .read(let message):
                XCTAssert(message == "Cannot find the data file")
            default:
                XCTFail("Wrong error message")
            }
        }
    }
    
    func testWrongEncoding() throws {
        let x = Bundle(for: FitBodWeightTests.self)
        let url = x.url(forResource: "workoutDataWrongEncoding", withExtension: "txt")
        let manager = WorkoutManager.test(url: url)
        switch manager.data {
        case .success:
            XCTFail("It should fail!")
        case .failure(let error):
            switch error {
            case .read(let message):
                XCTAssert(message == "Cannot read the workout data file")
            default:
                XCTFail("Wrong error message")
            }
        }
    }
    
    func testWrongColumns() throws {
        let x = Bundle(for: FitBodWeightTests.self)
        let url = x.url(forResource: "workoutDataWrongColumns", withExtension: "txt")
        let manager = WorkoutManager.test(url: url)
        switch manager.data {
        case .success:
            XCTFail("It should fail!")
        case .failure(let error):
            switch error {
            case .workout(let message, lineno: let lineno):
                XCTAssert(message == "Invalid component counts" && lineno == 2)
            default:
                XCTFail("Wrong error message")
            }
        }
    }
    
    func testWrongDateOfWork() throws {
        let x = Bundle(for: FitBodWeightTests.self)
        let url = x.url(forResource: "workoutDataWrongDateOfWork", withExtension: "txt")
        let manager = WorkoutManager.test(url: url)
        switch manager.data {
        case .success:
            XCTFail("It should fail!")
        case .failure(let error):
            switch error {
            case .workout(let message, lineno: let lineno):
                XCTAssert(message == "Invalid dateOfWorkout" && lineno == 1)
            default:
                XCTFail("Wrong error message")
            }
        }
    }
    
    func testWrongReps() throws {
        let x = Bundle(for: FitBodWeightTests.self)
        let url = x.url(forResource: "workoutDataWrongReps", withExtension: "txt")
        let manager = WorkoutManager.test(url: url)
        switch manager.data {
        case .success:
            XCTFail("It should fail!")
        case .failure(let error):
            switch error {
            case .workout(let message, lineno: let lineno):
                XCTAssert(message == "Invalid reps" && lineno == 1)
            default:
                XCTFail("Wrong error message")
            }
        }
    }
    
    func testWrongWeight() throws {
        let x = Bundle(for: FitBodWeightTests.self)
        let url = x.url(forResource: "workoutDataWrongWeight", withExtension: "txt")
        let manager = WorkoutManager.test(url: url)
        switch manager.data {
        case .success:
            XCTFail("It should fail!")
        case .failure(let error):
            switch error {
            case .workout(let message, lineno: let lineno):
                XCTAssert(message == "Invalid weight" && lineno == 1)
            default:
                XCTFail("Wrong error message")
            }
        }
    }
}
