//
//  Optional.swift
//  
//
//  Created by Anna Münster on 19.01.23.
//

import Foundation

public extension Optional where Wrapped == String {
    var isEmpty: Bool {
        self?.isEmpty ?? true
    }
}

public extension Optional where Wrapped: Collection {
    var isEmpty: Bool {
        self?.isEmpty ?? true
    }
}

public extension Optional where Wrapped == NSSet {
    var isEmpty: Bool {
        self?.count == 0
    }
}
