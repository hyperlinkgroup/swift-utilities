//
//  Data.swift
//  Plantbuddy
//
//  Created by Kevin Waltz on 15.08.22.
//  Copyright © 2022 spacesquad. All rights reserved.
//

import Foundation

public extension Data {
    /**
     Text in utf8 umwandeln.
     
     Umwandlung zum Anhängen an eine URL.
     
     Die URL wird angepingt, ohne auf eine Antwort zu warten.
     
     - Parameter string: Text zur Umwandlung
     */
    public mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
    
    public var prettyPrintedJSONString: NSString? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
