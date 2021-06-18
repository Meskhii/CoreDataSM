//
//  EmailViewModel.swift
//  CoreDataSimpleEmail
//
//  Created by user200328 on 6/18/21.
//

import Foundation

protocol EmailViewModelProtocol: AnyObject {
    func fetchRecievedEmails(for user: User?, completion: @escaping ([Email]) -> Void)
    
    var user: User? { get }
    
    init(with coreDataManager: CoreDataManagerProtocol, user: User?)
}

final class EmailViewModel: EmailViewModelProtocol {
    
    private let coreDataManager: CoreDataManagerProtocol
    
    private(set) var user: User?
    
    init(with coreDataManager: CoreDataManagerProtocol, user: User?) {
        self.coreDataManager = coreDataManager
        self.user = user
    }
    
    func fetchRecievedEmails(for user: User?, completion: @escaping ([Email]) -> Void) {
        coreDataManager.fetchRecievedEmails(for: user, completion: completion)
    }
    
}

