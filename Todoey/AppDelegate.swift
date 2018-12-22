//
//  AppDelegate.swift
//  Todoey
//
//  Created by Hina Ali on 12/7/18.
//  Copyright © 2018 Hina Khalid. All rights reserved.
//

import UIKit
import RealmSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       // print(Realm.Configuration.defaultConfiguration.fileURL!)
        //let data = Data()
       // data.name = "AliHina"
        do {
            _ = try Realm()
         
        }
        catch
        {
            print("Error intialising new Realm , \(error)")
        }
        print("applicationdidFinishLaunching")
        return true
    }


}

