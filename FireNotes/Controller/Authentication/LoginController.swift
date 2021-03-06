//
//  LoginController.swift
//  FireNotes
//
//  Created by malakoipechyva on 23.03.21.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    //MARK: - Properties

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "notes")
        return iv
    }()
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "envelope")
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
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.backgroundColor = .amber
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account", " Sign up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUserAndConfigureUI()
    }
    
    //MARK: - Selectors
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, err) in
            if let error = err {
                print("DEBUG: Error logging in with error: \(error.localizedDescription)")
                return
            }
            guard let uid = Auth.auth().currentUser?.uid else { return }
            self.navigationController?.pushViewController(NotesController(uid: uid), animated: true)
        }
    }
    
    @objc func handleShowSignUp() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: - API
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            configureUI()
        } else {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            navigationController?.pushViewController(NotesController(uid: uid), animated: true)
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .darkGray
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view)
        logoImageView.setDimensions(width: 83, height: 83)
        logoImageView.anchor(top: view.topAnchor, paddingTop: 45)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, right: view.rightAnchor,
                     paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor,
                                     bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                     paddingLeft: 40, paddingRight: 40)
    }
}
