//
//  AppStoreReviewManager.swift
//  AppReview
//
//  Created by Eunchan Kim on 2023/06/26.
//

import StoreKit

enum AppStoreReviewManager{
    private static let minimumReviewWorthyActionCount = 5
    private static var actionCount: Int{
        get {UserDefaults.standard.integer(forKey: "actionCount")}
        set {UserDefaults.standard.set(newValue, forKey: "actionCount")}
    }
    
    static func requestReviewIfAppropriate(){
        self.actionCount += 1
        guard self.actionCount >= minimumReviewWorthyActionCount else {return}
        
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = UserDefaults.standard.string(forKey: "lastVersion")
        guard lastVersion == nil || lastVersion != currentVersion else {return}
        
        if #available(iOS 14.0, *){
            guard let scene = UIApplication
            .shared
            .connectedScenes
            .first(where: {$0.activationState == .foregroundActive}) as? UIWindowScene
            else {return}
            SKStoreReviewController.requestReview(in: scene)
        } else {
            SKStoreReviewController.requestReview()
        }
    }
}
