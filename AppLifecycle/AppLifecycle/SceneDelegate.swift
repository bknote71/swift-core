//
//  SceneDelegate.swift
//  AppLifecycle
//
//  Created by bknote71 on 8/2/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  var backgroundTask: UIBackgroundTaskIdentifier?

  // iOS 13 이후 생명 주기 관리가 AppDelegate와 SceneDelegate로 나누어진다.
  // inactive, active, background 생명주기에 대한 콜백을 수행할 수 있다.
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let _ = (scene as? UIWindowScene) else { return }
    print("Scene wil connect to session")
  }

  func sceneDidDisconnect(_ scene: UIScene) {
  }

  // Inactive to Active
  func sceneDidBecomeActive(_ scene: UIScene) {
    print("scene did become active")
  }

  // Active to Inactive
  func sceneWillResignActive(_ scene: UIScene) {
    print("scene will resign active")
  }

  // background to foreground
  func sceneWillEnterForeground(_ scene: UIScene) {
    print("scene will enter foreground")
  }

  // foreground to background
  func sceneDidEnterBackground(_ scene: UIScene) {
    print("scene did enter background")
    // 1. 스레드
    Thread {
      while(true) {
        // 1초 슬립
        Thread.sleep(forTimeInterval: 1)
        print("background-thread")
      }
    }.start()
    
    // 2. timer
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
      print("background-timer")
    }
    
    // 3. background task
    backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "MyBackgroundTask") { [weak self] in
      self?.endBackgroundTask()
    }
    
    DispatchQueue.global().async {
      while(true) {
        // 1초 슬립
        Thread.sleep(forTimeInterval: 1)
        print("background-task")
      }
    }
  }
  
  private func endBackgroundTask() {
    print("end background task")
    guard let backgroundTask else { return }
    if backgroundTask != .invalid {
      UIApplication.shared.endBackgroundTask(backgroundTask)
      self.backgroundTask = .invalid
    }
  }
}

