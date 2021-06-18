//
//  SentEmailsViewController.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class SentEmailsViewController: UIViewController {
    
    // MARK: - Variables
    private var dataSource: SentEmailsDataSource!
    private var viewModel: SentEmailsViewModelProtocol!
    var user: User?

    // MARK: - IBOutlet
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
    
    // MARK: - View Model Configuration
    private func configureViewModel() {
        viewModel = SentEmailsViewModel(with: CoreDataManager(), user: user)
        dataSource = SentEmailsDataSource(with: tableView, viewModel: viewModel)
        
        dataSource.refresh()
    }
    
}
