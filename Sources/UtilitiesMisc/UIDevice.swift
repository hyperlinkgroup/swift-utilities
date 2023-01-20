//
//  UIDevice.swift
//  
//
//  Created by Kevin Waltz on 22.06.20.
//

import UIKit

public extension UIDevice {
    
    /**
     Überprüfung, ob verwendetes Gerät ein iPad ist oder  nicht.
     */
    static let isiPad = UIDevice.current.userInterfaceIdiom == .pad
    
    /**
    Der Modelname für reale Geräte (funktioniert nicht für den Simulator!) wird aus den Systeminfos gelesen.
    Achtung! Dieser Wert sollte nicht dem User angezeigt werden, dafür muss bei Bedarf noch ein Mapping gebaut werden!
    (für ein iPhone 7 ist der modelName hier z.B"iPhone9,1"oder "iPhone9,3")
     */
    static var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        return identifier
    }

    /**
     Unique Identifier eines Geräts gültig für alle SSQ-Apps
     */
    static var uuid: String? {
        UIDevice.current.identifierForVendor?.uuidString
    }
    
}
