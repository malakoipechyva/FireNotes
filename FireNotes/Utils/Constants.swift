//
//  Constants.swift
//  FireNotes
//
//  Created by malakoipechyva on 25.03.21.
//

import Firebase

let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_NOTES = DB_REF.child("notes")
let REF_USER_NOTES = DB_REF.child("user_notes")
