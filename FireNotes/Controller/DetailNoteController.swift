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
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setImage(UIImage(named: "Checkmark"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
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
        guard let noteText = uploadNoteTextView.text else { return }
        NoteService.shared.uploadNote(text: noteText) { (err, ref) in
            print("DEBUG: note successfully uploaded to firebase")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .amber
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addNoteButton)
        
    }
}
