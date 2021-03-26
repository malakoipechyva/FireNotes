//
//  NotesController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

class NotesController: UITableViewController {
    
    //MARK: - Properties
    
    private let addNoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "Plus_Circle"), for: .normal)
        button.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func addNoteButtonTapped() {
        let nav = UINavigationController(rootViewController: UploadNoteController())
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .gray
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(addNoteButton)
        addNoteButton.centerX(inView: view)
        addNoteButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20)
    }
}
