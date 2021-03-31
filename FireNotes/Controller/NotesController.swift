//
//  NotesController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

private let reuseIdentifier = "NoteCell"

class NotesController: UITableViewController {
    
    //MARK: - Properties
    
    private var notes = [Note]()
    
    private let addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(named: "Plus_Circle"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchNotes()
    }
    
    //MARK: - Selectors
    
    @objc func addNoteButtonTapped() {
        let nav = UINavigationController(rootViewController: UploadNoteController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    //MARK: - API
    
    func fetchNotes() {
        NoteService.shared.fetchNotes { notes in
            print(notes)
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(addNoteButton)
        addNoteButton.centerX(inView: view)
        addNoteButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
    }
}

extension NotesController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
    }
}
