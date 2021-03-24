//
//  RegistrationController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private lazy var emailContainerView: UIView = {
        let image =   #imageLiteral(resourceName: "envelope")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "lock")
        let view = Utilities().inputContainerView(withImage: image,textField: passwordTextField)
        return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Email")
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = Utilities().textField(withPlaceholder: "Password")
        tf.isSecureTextEntry = false
        return tf
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.backgroundColor = .amber
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account", " Log in")
        button.addTarget(self, action: #selector(handleShowLoginScreen), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleRegistration() {
        print("DEBUG: Handle registrartion...")
    }
    
    @objc func handleShowLoginScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .darkGray
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor,
                     paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor,
                                        bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                        paddingLeft: 40, paddingRight: 40)
    }
}
