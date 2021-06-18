//
//  ComposeViewController.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit
import CoreData

class ComposeViewController: UIViewController {
    
    // MARK: - Variables
    var context: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    }
    
    private var coreDataManager: CoreDataManagerProtocol!
    var user: User?
    var recieverUser: User?

    // MARK: - IBOutlets
    @IBOutlet weak var sendToTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataManager = CoreDataManager()
    }
    
    // MARK: = IBActions
    @IBAction func cancelTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendTapped(_ sender: Any) {
        if checkInputs() {
            if getRecieverUser() {
                sendEmail()
            }
        } else {
            showAlert(with: "Fill All Fields")
        }
    }
    
    // MARK: - Method For Reciever User
    private func getRecieverUser() -> Bool {
        var recieverFound = false
        
        coreDataManager.checkReciever(email: sendToTextField.text!) { result in
            switch result {
            case .success(let user):
                guard let recieverUser = user else {return}
                self.recieverUser = recieverUser
                recieverFound = true
            case .failure(let error):
                self.showAlert(with: "\(error)")
            }
        }
        
        return recieverFound
    }
    
    // MARK: - Sending Email
    private func sendEmail() {
        guard let context = context else { return }
        
        let email = Email(context: context)
        email.emailContext = messageTextView.text!
        email.subject = subjectTextField.text!
        
        user?.addToSentEmails(email)
        recieverUser?.addToRecievedEmails(email)
        
        coreDataManager.saveEmail(with: email) { success in
            if success {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.showAlert(with: "Unknown Error")
            }
        }
    }
    
    // MARK: - Field Validation
    private func checkInputs() -> Bool {
        return sendToTextField.hasText || subjectTextField.hasText || messageTextView.hasText
    }
    
    private func showAlert(with message: String) {
         
         let alert = UIAlertController(title: "Error",
                                       message: message,
                                       preferredStyle: .alert)

         alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

         self.present(alert, animated: true)
     }
    
}
