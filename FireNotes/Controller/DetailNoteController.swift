//
//  DetailNoteController.swift
//  FireNotes
//
//  Created by malakoipechyva on 31.03.21.
//

import UIKit

class DetailNoteController: UIViewController {
    
    //MARK: - Properties
    
    private var note: Note
    
    private let noteTextView: UITextView = {
       let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Checkmark"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var deleteNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .red
        button.setImage(UIImage(named: "trash"), for: .normal)
        button.addTarget(self, action: #selector(deleteNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(note: Note) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func addNoteButtonTapped() {
        guard let noteText = noteTextView.text else { return }
        let noteID = note.noteID
        
        NoteService.shared.editNote(noteID: noteID, text: noteText) { (err, ref) in
            print("DEBUG: note successfully edited and uploaded to firebase")
        }
        navigationController?.popViewController(animated: true)
    }
    
    @objc func deleteNoteButtonTapped() {
        NoteService.shared.deleteNote(noteID: note.noteID) { (err, ref) in
            print("DEBUG: note successfully removed from firebase")
        }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addNoteButton)
        
        noteTextView.text = note.text
        view.addSubview(noteTextView)
        noteTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                  paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
        
        view.addSubview(deleteNoteButton)
        deleteNoteButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingBottom: 20, paddingRight: 30)
    }
}
