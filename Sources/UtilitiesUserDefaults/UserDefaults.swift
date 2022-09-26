//
//  UserDefaults.swift
//
//
//  Created by Kevin Waltz on 26.08.21.
//

import Foundation

public protocol Key {
    var rawValue: String { get }
}

extension UserDefaults {
    public static func save(_ value: Any?, forKey key: Key) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    public static func getString(forKey key: Key) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    public static func getBool(forKey key: Key) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    public static func getObject(forKey key: Key) -> Any? {
        UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    public static func getInteger(forKey key: Key) -> Int {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    public static func getDouble(forKey key: Key) -> Double {
        UserDefaults.standard.double(forKey: key.rawValue)
    }
    
    public static func delete(forKey key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    public static func isKeyMissing(_ key: Key) -> Bool {
        UserDefaults.standard.object(forKey: key.rawValue) == nil
    }
}
