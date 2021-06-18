//
//  SentEmailsDataSource.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import UIKit

class SentEmailsDataSource: NSObject {
    
    // MARK: - Variables
    private var tableView: UITableView!
    private var viewModel: SentEmailsViewModelProtocol!
    private var emailsList = [Email]()
    
    // MARK: - Init
    init(with tableView: UITableView, viewModel: SentEmailsViewModelProtocol) {
        super.init()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.viewModel = viewModel
    }
    
    // MARK: - Fetcher
    func refresh() {
        
        viewModel.fetchSentEmails(for: viewModel.user) { emails in
            self.emailsList = emails
            self.tableView.reloadData()
        }
        
    }
}

// MARK: - UITableView Data Source & Delegate
extension SentEmailsDataSource: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(EmailCell.self, for: indexPath)
        cell.configure(with: emailsList[indexPath.row])
        return cell
    }
    
}
