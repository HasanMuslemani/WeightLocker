//
//  CoreDataStack.swift
//  Weight Locker
//
//  Created by Hasan Muslemani on 11/8/20.
//

import Foundation
import CoreData

class CoreDataManager {
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        //create the persistent container
        let container = NSPersistentContainer(name: self.modelName)
        
        //create the persistent store for the container
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            
            //check if error occured while creating persistent store
            if let error = error {
                fatalError("Unresolved error creating persistent store : \(error): \(error.localizedDescription)")
            }
        })
        
        return container
    }()
    
    //the context for our persistent container
    lazy var managedContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    //method to save the context if it has changes
    func saveContext() {
        //check for changes
        guard managedContext.hasChanges else {return}
        
        do {
            //try to save the context
            try managedContext.save()
        } catch {
            //error occured
            fatalError("Unresolved error trying to save the context: \(error) : \(error.localizedDescription)")
        }
    }
    
    func fetchWeightTerms(weightTermTracker: WeightTermTracker) {
        let fetchRequest: NSFetchRequest<WeightTerm>  = WeightTerm.fetchRequest()
        
        do {
            var allWeightTerms = try managedContext.fetch(fetchRequest)
            var weightTermsInProgress: [WeightTerm] = []
            for weightTerm in allWeightTerms {
                if(weightTerm.endWeight == -1 && weightTerm.isCurrent == false) {
                    weightTermsInProgress.append(weightTerm)
                    let index = allWeightTerms.firstIndex(of: weightTerm)
                    allWeightTerms.remove(at: index!)
                } else if(weightTerm.isCurrent) {
                    weightTermTracker.currentWeightTerm = weightTerm
                    let index = allWeightTerms.firstIndex(of: weightTerm)
                    allWeightTerms.remove(at: index!)
                }
            }
            weightTermTracker.allWeightTerms = allWeightTerms
            weightTermTracker.weightTermsInProgress = weightTermsInProgress
        } catch {
            fatalError("Problem fetching weight terms \(error) : \(error.localizedDescription)")
        }
    }
    
    func fetchPhotos(photoTracker: PhotoTracker) {
        let fetchRequest: NSFetchRequest<Photo> = Photo.fetchRequest()
        
        do {
            photoTracker.photos = try managedContext.fetch(fetchRequest)
        } catch {
            fatalError("Problem fetching photos \(error) : \(error.localizedDescription)")
        }
    }
    
}
