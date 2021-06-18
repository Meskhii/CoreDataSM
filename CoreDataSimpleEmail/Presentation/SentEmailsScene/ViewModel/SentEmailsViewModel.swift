//
//  SentEmailsViewModel.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import Foundation

protocol SentEmailsViewModelProtocol: AnyObject {
    func fetchSentEmails(for user: User?, completion: @escaping ([Email]) -> Void)
    
    var user: User? { get }
    
    init(with coreDataManager: CoreDataManagerProtocol, user: User?)
}

final class SentEmailsViewModel: SentEmailsViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    private(set) var user: User?
    
    init(with coreDataManager: CoreDataManagerProtocol, user: User?) {
        self.coreDataManager = coreDataManager
        self.user = user
    }
    
    func fetchSentEmails(for user: User?, completion: @escaping ([Email]) -> Void) {
        coreDataManager.fetchSentEmails(for: user, completion: completion)
    }
    
}

