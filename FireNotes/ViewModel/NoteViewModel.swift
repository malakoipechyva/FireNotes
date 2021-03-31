//
//  NoteViewModel.swift
//  FireNotes
//
//  Created by malakoipechyva on 31.03.21.
//

import Foundation

struct NoteViewModel {
    
    //MARK: - Properties
    
    let note: Note
    
    var noteTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ⏤ MM/dd/yyyy"
        return formatter.string(from: note.timestamp)
    }
    
    //MARK: - Lifecycle
    
    init(note: Note) {
        self.note = note
    }
    
}
