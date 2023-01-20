//
//  UIApplication.swift
//  
//
//  Created by Anna Münster on 21.09.22.
//

#if !os(macOS)
import UIKit

public extension UIApplication {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?.windows
            .first(where: \.isKeyWindow)
    }
    
    static var visibleViewController: UIViewController? {
        keyWindow?.rootViewController?.presentedViewController ?? keyWindow?.rootViewController
    }
    
    /**
     Prüft, ob die Hierarchie der Application `UIRemoteKeyboardWindow` enthält, wenn ja heißt das, dass die Tastatur angezeigt
    */
    var isKeyboardPresented: Bool {
        guard let keyboardWindowClass = NSClassFromString("UIRemoteKeyboardWindow") else { return false }
        
        return UIApplication.shared.windows.contains(where: { $0.isKind(of: keyboardWindowClass) })
    }
}
#endif
