//
//  NoteService.swift
//  FireNotes
//
//  Created by malakoipechyva on 30.03.21.
//

import Firebase

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct NoteService {
    
    static let shared = NoteService()
    
    func uploadNote(text: String, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let values = ["uid": uid,
                      "text": text,
                      "timestamp": Int(NSDate().timeIntervalSince1970)] as [String: Any]
        
        REF_NOTES.childByAutoId().updateChildValues(values) { (err, ref) in
            guard let noteID = ref.key else { return }
            REF_USER_NOTES.child(uid).updateChildValues([noteID: 1], withCompletionBlock: completion)
        }
    }
    
    func editNote(noteID: String, text: String, completion: @escaping(DatabaseCompletion)) {
        let values = ["text": text,
                      "timestamp": Int(NSDate().timeIntervalSince1970)] as [String: Any]
        
        REF_NOTES.child(noteID).updateChildValues(values)
    }
    
    func fetchUserNotes(forUser uid: String, completion: @escaping([Note]) -> Void) {
        var notes = [Note]()
        
        REF_USER_NOTES.child(uid).observe(.childAdded) { snapshot in
            let noteID = snapshot.key
            
            REF_NOTES.child(noteID).observeSingleEvent(of: .value) { snapshot in
                guard let dictionary = snapshot.value as? [String: Any] else { return }
                let noteID = snapshot.key
                let note = Note(noteID: noteID, dictionary: dictionary)
                notes.append(note)
                completion(notes)
            }
        }
    }
    
    func deleteNote(noteID: String) {
        REF_NOTES.child(noteID).removeValue()
    }
}
