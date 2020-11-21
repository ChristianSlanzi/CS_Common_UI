//
//  Dictionary+Ext.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 21.11.20.
//

public extension Dictionary {
    subscript(i: Int) -> (key: Key, value: Value) {
        get {
            return self[index(startIndex, offsetBy: i)]
        }
    }
}
