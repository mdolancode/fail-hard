//
//  CoreDataManager.swift
//  fail-hard
//
//  Created by Matthew Dolan on 2024-10-12.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "WorkoutModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to load Core Data store: \(error)")
            }
        }
    }
    
    func saveWorkout(name: String, date: Date) {
        let context = persistentContainer.viewContext
        let workout = Workout(context: context)
        workout.name = name
        workout.date = date
        
        do {
            try context.save()
        } catch {
            print("Failed to save workout: \(error)")
        }
    }
    
    func updateWorkout(workout: Workout, newName: String) {
        workout.name = newName
        saveContext()
    }
    
    func deleteWorkout(workout: Workout) {
        let context = persistentContainer.viewContext
        context.delete(workout)
        saveContext()
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
            print("Changes saved successfully!")
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
    
    func FetchWorkouts() -> [Workout] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Workout> = Workout.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch workouts: \(error)")
            return []
        }
    }
}
        
