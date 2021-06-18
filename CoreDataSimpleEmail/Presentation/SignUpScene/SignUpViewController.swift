//
//  SignUpViewController.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Variables
    private var coreDataManager: CoreDataManagerProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                       print(paths[0])
   
        coreDataManager = CoreDataManager()
    }
    
    // MARK: - IBAction
    @IBAction func signUpTapped(_ sender: Any) {
        if checkInputs() {
            if registerUser() {
                popToWelcomePage()
            } else {
                showAlert(with: "Registration Error")
            }
        } else {
            showAlert(with: "Feel All Fields")
        }
    }
    
    // MARK: - Registration Validations
    private func checkInputs() -> Bool {
        return emailTextField.hasText || passwordTextField.hasText
    }
    
    private func registerUser() -> Bool {
        var registrationSuccess = false
        coreDataManager.register(with: emailTextField.text!, and: passwordTextField.text!) { success in
            registrationSuccess = success
        }
        return registrationSuccess
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "Error",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
     
     // MARK: - Navigation Method
     private func popToWelcomePage(){
        self.navigationController?.popViewController(animated: true)
     }
        
}
