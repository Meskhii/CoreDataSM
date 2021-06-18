//
//  WelcomeViewController.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
    }
    

    
    @IBAction func loginTapped(_ sender: Any) {
        navigateTo(vc: VCIds.loginVC)
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        navigateTo(vc: VCIds.signUpVC)
    }
    
    private func navigateTo(vc: String) {
        let sb  = UIStoryboard(name: vc, bundle: nil)
        let toVC = sb.instantiateViewController(withIdentifier: vc)
        
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
}
