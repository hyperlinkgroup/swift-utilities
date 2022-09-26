//
//  Log.swift
//  
//
//  Created by Anna Münster on 23.09.22.
//

/**
 Custom Log Function to be used instead of print(). Adds File and Line-Number to console output.
 */
public func log(_ items: Any..., file: String = #fileID, line: Int = #line) {
    // if items is not an array (usually it is a single string) it is transferred to single element and optionals are unwrapped
    let item = items.count > 1 ? items : items.first ?? ""
    Swift.print("\(file):\(line) ----> \(item)")
}
