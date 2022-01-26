//
//  TransactionViewController.swift
//  IA_Test
//
//  Created by Luis García on 26/01/22.
//

import UIKit

class TransactionViewController: UIViewController {

    // MARK: - Variable declaration
    lazy var mainView: TransactionView? = {
        return TransactionView(frame: UIScreen.main.bounds, transactions: self.transactions)
    }()
    private let transactions: TransactionsResponse
    
    // MARK: - Override Methods
    init(transactions: TransactionsResponse) {
        self.transactions = transactions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    
    // MARK: - Initializers
    private func initUI() {
        self.view.backgroundColor = .white
    }
}
