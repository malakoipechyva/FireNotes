//
//  Note.swift
//  FireNotes
//
//  Created by malakoipechyva on 30.03.21.
//

import Foundation

struct Note {
    
    let uid: String
    let noteID: String
    let text: String
    let timestamp: Date
    
    init(noteID: String, dictionary: [String: Any]) {
        self.noteID = noteID
        
        self.uid = dictionary["uid"] as? String ?? ""
        self.text = dictionary["text"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        } else {
            self.timestamp = Date(timeIntervalSince1970: 0)
        }
    }
    
}
