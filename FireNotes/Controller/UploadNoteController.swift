//
//  UploadNoteController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

class UploadNoteController: UIViewController {
    
    //MARK: - Properties
    private lazy var addNoteButton: UIButton = {
        let button = UIButton(type: .system)
    
        button.tintColor = .systemBlue
        button.setImage(UIImage(named: "Checkmark"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
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
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addNoteButton)
    }
}
