//
//  SceneDelegate.swift
//  SeSAC Shopping(CodeBase)
//
//  Created by 남현정 on 2024/01/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 이미 사용자의 정보가 유저디폴트에 있다면 tabbarcontroller
        if let nickname = UserDefaultManager.shared.ud.string(forKey: "UserNickname") {
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(frame: scene.coordinateSpace.bounds)
            window?.windowScene = scene
            let tabBarVC = UITabBarController()
            
            let firstNav = UINavigationController(rootViewController: SearchViewController())
            let secondNav = UINavigationController(rootViewController: SettingViewController())
            
            firstNav.tabBarItem = UITabBarItem(title: "검색", image: UIImage(systemName: "magnifyingglass"), tag: 0)
            secondNav.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "person"), tag: 1)
            
            tabBarVC.tabBar.tintColor = CustomColor.pointColor // 탭바의 tintcolor주기
            
            tabBarVC.viewControllers = [firstNav, secondNav]
            
            window?.rootViewController = tabBarVC
            window?.makeKeyAndVisible()
            
            
        } else {
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            let navi = UINavigationController(rootViewController: OnboardingViewController())
            
            window?.rootViewController = navi
            window?.makeKeyAndVisible()

        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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

