//
//  SceneDelegate.swift
//  MySecuXPay
//
//  Created by Maochun Sun on 2020/1/16.
//  Copyright © 2020 SecuX. All rights reserved.
//

import UIKit



class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        let rootVC = ViewController();
        //let rootVC = MapViewController()
        
        //let rootVC = TestModeViewController();
        //let navRootVC = SunUINavigationController(rootViewController: rootVC)
        
        let navRootVC = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        
        navRootVC.viewControllers = [rootVC]
    
        navRootVC.navigationBar.barStyle = .black
        navRootVC.navigationBar.tintColor = UIColor.white
        //navRootVC.navigationBar.barTintColor = .blue
        navRootVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white];
        
        navRootVC.navigationBar.shadowImage = UIImage()
        navRootVC.navigationBar.backIndicatorImage = UIImage()
        navRootVC.navigationBar.isTranslucent = false
        
        navRootVC.navigationBar.barTintColor = UIColor(red: 0x1F/0xFF, green: 0x20/0xFF, blue: 0x20/0xFF, alpha: 1)
        navRootVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Arial", size: 24)!,
                                                                       NSAttributedString.Key.foregroundColor: UIColor.white]
        
    
        let titleImgView = UIImageView(image: UIImage(named: "SecuX_Logo"))
        titleImgView.translatesAutoresizingMaskIntoConstraints = false
        navRootVC.navigationBar.addSubview(titleImgView)
        titleImgView.centerXAnchor.constraint(equalTo: navRootVC.navigationBar.centerXAnchor).isActive = true
        titleImgView.centerYAnchor.constraint(equalTo: navRootVC.navigationBar.centerYAnchor).isActive = true
        
        
        
        
        
        self.window?.rootViewController = navRootVC
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

