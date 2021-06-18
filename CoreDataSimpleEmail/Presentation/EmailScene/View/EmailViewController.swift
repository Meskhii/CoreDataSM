//
//  EmailViewController.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class EmailViewController: UIViewController {
    
    // MARK: - Variables
    private var dataSource: EmailDataSource!
    private var viewModel: EmailViewModelProtocol!
    var user: User?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerNib(class: EmailCell.self)
        self.navigationController?.navigationBar.isHidden = false
        
        configureViewModel()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        dataSource.refresh()
    }
    
    // MARK: - IBActions
    @IBAction func openSentEmails(_ sender: Any) {
        guard let user = user else {return}
        navigateToSentEmails(with: user)
    }
    
    @IBAction func openEmailComposer(_ sender: Any) {
        guard let user = user else {return}
        navigateToComposer(with: user)
    }
    
    // MARK: - View Model Configuration
    private func configureViewModel() {
        viewModel = EmailViewModel(with: CoreDataManager(), user: user)
        dataSource = EmailDataSource(with: tableView, viewModel: viewModel)
        
        dataSource.refresh()
    }
    
    
    // MARK: - Navigation Method
    private func navigateToSentEmails(with user: User) {
        let sb = UIStoryboard(name: VCIds.sentEmailsVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.sentEmailsVC) as! SentEmailsViewController
       
        vc.user = user
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToComposer(with user: User) {
        let sb = UIStoryboard(name: VCIds.composeVC, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: VCIds.composeVC) as! ComposeViewController
       
        vc.user = user
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
