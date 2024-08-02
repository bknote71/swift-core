//
//  AppDelegate.swift
//  AppLifecycle
//
//  Created by bknote71 on 8/2/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  // MARK: - App Lifecycle
  
  // MARK: Not Running
  // - 앱이 실행되지 않은 상태(작업을 수행할 수 없음)
  // - 메모리에서 제거된 상태
  
  // Not Running to Running(Inactive)
  // - 앱이 처음 실행될 때 또는 종료된 후 다시 실행될 떄 실행
  func application(
    _ application: UIApplication,
    willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    print("App will finish launching")
    return true
  }

  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    print("App did finish launching")
    return true
  }
  
  // iOS 13 이전
  // iOS 13 이후 생명 주기 관리가 AppDelegate와 SceneDelegate로 나누어진다.
  // - 다음 아래 내용들은 13 이전에 호출된다.
  
  // MARK: - Inactive
  // - 포그라운드 상태지만 사용자 이벤트를 받을 수 없는 상태
  // - 일반적으로 잠깐동안 유지된다.
  // - 제한된 업데이트 작업 수행 (UI 업데이트나 중요한 작업을 멈추고, 필요한 상태 저장 작업 수행)
  // - Active 상태를 거치기 위해서 Inactive 상태를 거쳐야만 한다.
  // Active to Inactive
  func applicationWillResignActive(_ application: UIApplication) {
    print("will resign active")
  }
  
  // MARK: - Active
  // - 포그라운드 및 활성 상태 (사용자 이벤트를 받을 수 있다.)
  // - UI 업데이트 및 사용자 상호작용(이벤트) 처리
  // - Inactive to Active
  func applicationDidBecomeActive(_ application: UIApplication) {
    print("did become active")
  }
  
  // MARK: - Background
  // - 앱이 백그라운드에서 실행 중인 상태 (제한된 작업만 수행 가능)
  //.- 데이터 저장, 네트워크 응답 처리, 제한된 백그라운드 작업 수행 가능
  
  // Foreground to Background
  func applicationDidEnterBackground(_ application: UIApplication) {
    print("did enter background")
  }
  
  // to Foreground
  // - Not running to Running(Foreground)
  // - Background to Foreground
  func applicationWillEnterForeground(_ application: UIApplication) {
    print("will enter foreground")
  }
  
  // MARK: - Suspended
  // - 앱이 메모리에 있지만 실행되지 않는 상태(시스템이 자동으로 관리)
  // - 작업을 수행할 수 없다.
  // - 앱이 백그라운드에 들어간 후 특정 시간 동안 활동이 없으면, 일시 중단 상태로 전환
  // - CPU나 네트워크 리소스를 사용하지 않고, 시스템 메모리가 부족할 경우 종료될 수 있다.
  // - 앱이 활성화되면 didBecomeActive 메서드 호출
  

  // MARK: UISceneSession Lifecycle

  func application(
    _ application: UIApplication,
    configurationForConnecting connectingSceneSession: UISceneSession,
    options: UIScene.ConnectionOptions
  ) -> UISceneConfiguration {
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(
    _ application: UIApplication, 
    didDiscardSceneSessions sceneSessions: Set<UISceneSession>
  ) {
  }


}

