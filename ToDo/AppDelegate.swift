//
//  AppDelegate.swift
//  ToDo
//
//  Created by Krzysztof Lema on 21.02.2018.
//  Copyright © 2018 Krzysztof Lema. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(Realm.Configuration.defaultConfiguration.fileURL)
       
   
        do{
            _ = try Realm()
        }catch{
            print("Error initializing new Ralm,\(error)")
        }
        
        return true
    }
    
}


