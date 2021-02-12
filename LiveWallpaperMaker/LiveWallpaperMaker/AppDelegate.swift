//
//  AppDelegate.swift
//  LiveWallpaperMaker
//
//  Created by Twinbit Limited on 10/2/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        DocManager.makeFolder("Photo")
        DocManager.makeFolder("Video")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            if let imgPath = Bundle.main.path(forResource: "live_wallpaper_4", ofType: "jpg"){
//                let image = UIImage(contentsOfFile: imgPath)
//                let photoURL = DocManager.getFolderURL("Photo")
//                if let photoURLL = photoURL?.appendingPathComponent("live_wallpaper_4.jpg"){
//                    if FileManager.default.createFile(atPath: photoURLL.path, contents: image?.jpegData(compressionQuality: 1.0), attributes: nil){
//                        print(":-)")
//                    }
//                    else{
//                        print(":-(")
//                    }
//                }
//
//            }
//
//            if let videoPath = Bundle.main.path(forResource: "live_wallpaper_4", ofType: "mov"){
//                do {
//                    let data = try Data(contentsOf: URL(fileURLWithPath: videoPath))
//                    let videoURL = DocManager.getFolderURL("Video")
//                    if let videoURLL = videoURL?.appendingPathComponent("live_wallpaper_4.mov"){
//                        FileManager.default.createFile(atPath: videoURLL.path, contents: data, attributes: nil)
//                    }
//                } catch  {
//                    print(error.localizedDescription)
//                }
//
//
//            }
//
//        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

