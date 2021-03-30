//
//  NoteService.swift
//  FireNotes
//
//  Created by malakoipechyva on 30.03.21.
//

import Firebase

struct NoteService {
    
    static let shared = NoteService()
    
    func uploadNote(text: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "text": text,
                      "timestamp": Int(NSDate().timeIntervalSince1970)] as [String: Any]
        
        REF_NOTES.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
    
    func fetchNotes(completion: @escaping([Note]) -> Void) {
        var notes = [Note]()
        
        REF_NOTES.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let noteID = snapshot.key
            let note = Note(noteID: noteID, dictionary: dictionary)
            notes.append(note)
            completion(notes)
        }
    }
}
