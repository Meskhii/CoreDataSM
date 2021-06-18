//
//  LoginViewController.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Variables
    private var coreDataManager: CoreDataManagerProtocol!

    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataManager = CoreDataManager()
    }
    
    // MARK: - IBAction
    @IBAction func loginTapped(_ sender: Any) {
        if checkInputs() {
            loginUser()
        } else {
            showAlert(with: "Feel All Fields")
        }
    }
    
    // MARK: - Registration Validations
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
    
    private func loginUser() {
        coreDataManager.login(with: emailTextField.text!, and: passwordTextField.text!) { result in
            switch result {
            case .success(let user):
                guard let user = user else {return}
                self.navigateToEmail(with: user)
            case .failure(let error):
                self.showAlert(with: "\(error)")
            }
        }
     
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "Error",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
     
     // MARK: - Navigation Method
    private func navigateToEmail(with user: User) {
        let sb = UIStoryboard(name: VCIds.emailVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.emailVC) as! EmailViewController
        
        vc.user = user
        
        self.navigationController?.setViewControllers([vc], animated: true)
     }

}
