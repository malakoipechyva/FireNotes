//
//  UploadNoteController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

class UploadNoteController: UIViewController {
    
    //MARK: - Properties
    
    private let uploadNoteTextView = UploadNoteTextView()
    
    private lazy var addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setImage(UIImage(named: "Checkmark"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
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
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.leftBarButtonItem?.tintColor = .gray
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addNoteButton)
        
        view.addSubview(uploadNoteTextView)
        uploadNoteTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                  paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10)
    }
}
