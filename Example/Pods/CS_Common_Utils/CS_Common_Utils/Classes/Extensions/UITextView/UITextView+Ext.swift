//
//  UITextView+Ext.swift
//  CS_Common_Utils
//
//  Created by Christian Slanzi on 29.10.20.
//

import UIKit

public extension UITextView {

    typealias Match = (prefix: String, word: String, range: NSRange)
    
    func find(prefixes: Set<String>, with delimiterSet: CharacterSet) -> Match? {
        guard prefixes.count > 0 else { return nil }

        for prefix in prefixes {
            if let match = find(prefix: prefix, with: delimiterSet) {
                return match
            }
        }
        return nil
    }
    
    func find(prefix: String, with delimiterSet: CharacterSet) -> Match? {
        guard !prefix.isEmpty else { return nil }
        guard let caretRange = self.caretRange else { return nil }
        guard let cursorRange = Range(caretRange, in: text) else { return nil }
        
        let leadingText = text[..<cursorRange.upperBound]
        var prefixStartIndex: String.Index!
        for (i, char) in prefix.enumerated() {
            guard let index = leadingText.lastIndex(of: char) else { return nil }
            if i == 0 {
                prefixStartIndex = index
            } else if index.utf16Offset(in: leadingText) == prefixStartIndex.utf16Offset(in: leadingText) + 1 {
                prefixStartIndex = index
            } else {
                return nil
            }
        }

        let wordRange = prefixStartIndex..<cursorRange.upperBound
        let word = leadingText[wordRange]
        
        let location = wordRange.lowerBound.utf16Offset(in: leadingText)
        let length = wordRange.upperBound.utf16Offset(in: word) - location
        let range = NSRange(location: location, length: length)
        
        return (String(prefix), String(word), range)
    }

    var caretRange: NSRange? {
        guard let selectedRange = self.selectedTextRange else { return nil }
        return NSRange(
            location: offset(from: beginningOfDocument, to: selectedRange.start),
            length: offset(from: selectedRange.start, to: selectedRange.end)
        )
    }
    
}
