//
//  AppStoreReviewManager.swift
//  AppReview
//
//  Created by Eunchan Kim on 2023/06/26.
//

import StoreKit

// 버튼이 눌린 횟수를 카운팅 하도록 설정하기 위해서 필요한 프로퍼티를 정의합니다
enum AppStoreReviewManager{
    private static let minimumReviewWorthyActionCount = 5
    private static var actionCount: Int{
        get {UserDefaults.standard.integer(forKey: "actionCount")}
        set {UserDefaults.standard.set(newValue, forKey: "actionCount")}
    }
    
    //메소드 정의
    static func requestReviewIfAppropriate(){
        //해당 메서드가 불릴 때 카운트를 올려주는 코드!
        self.actionCount += 1
        guard self.actionCount >= minimumReviewWorthyActionCount else {return}
        
        
        //버전 정보를 불러와서 해당 버전이 최초 버전이거나 현재 버전과 지난 버전이 다른 경우 리뷰를 새로 요청해야 하므로 분기문을 추가한다.
        //lastVersion과 같은 값은, 별점 팝업에서 yes버튼을 누른 경우, 값 입력
        let bundleVersionKey = kCFBundleVersionKey as String
        let currentVersion = Bundle.main.object(forInfoDictionaryKey: bundleVersionKey) as? String
        let lastVersion = UserDefaults.standard.string(forKey: "lastVersion")
        guard lastVersion == nil || lastVersion != currentVersion else {return}
        
        //SKStoreReviewController.requestReview() 를 사용하여 리뷰 팝업 띄우기
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
    
    /**
    - 주의
     - requestReview()를 요청해도 애플의 내부 코드에 의해서 요청이 무시될 수 있므로, "리뷰 요청하기" 버튼과 같은 것을 만들고 리뷰 팝업이 뜨게끔하는 코드를 짜지 말것
     - TestFlight에서 리뷰 요청 테스트를 마음껏 가능 (리뷰를 해도 실제 반영 x)
     - requestReview()을 여러번 요청해도 production환경에서는 일년에 3번 제한되고 requestReview()를 요청하는 일년 중 3번 랜덤으로 노출(debug환경에서는 계속 노출)
     */
}
