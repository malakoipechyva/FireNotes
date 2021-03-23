//
//  LoginController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var emailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .cyan
    }
}
