//
//  Collection.swift
//  Fudge
//
//  Created by Matt on 3/27/16.
//  Copyright © 2016 fudgeInc. All rights reserved.
//

import UIKit
import Parse

class Collection: NSObject {
    var recipes: [Int]?
    var owner: PFUser?
    var collaborators: [PFUser]?
    var collectionId: String?
    var name:String?
    
    init(obj: PFObject) {
        //TODO: see if we can cast it like this
        collectionId = obj.objectId
        recipes = obj["Recipes"] as? [Int]
        owner = obj["Owner"] as? PFUser
        collaborators = obj["Collaborators"] as? [PFUser]
        name = obj["Name"] as? String
    }
    
    //TODO: add methods to make recipe collection from an array
    class func getRecipesForCollection(collection:Collection)->[Recipe]{
        let collectionId = collection.collectionId!
        
        //query the backend to get the recipes for our collection
        let query = PFQuery(className: "Recipe")
        query.whereKey("collections", equalTo: collectionId)
        query.findObjectsInBackgroundWithBlock { (results:[PFObject]?, error:NSError?) in
            if error == nil{
                //if there's no error it went through correctly
                if let results = results{
                    return Recipe.recipesForArray(results)
                }
            }else{
                NSLog((error?.localizedDescription)!)
            }
        }
    }
}
