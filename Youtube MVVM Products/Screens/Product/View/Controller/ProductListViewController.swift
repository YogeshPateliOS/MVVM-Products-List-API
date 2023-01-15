 //
//  ProductListViewController.swift
//  Youtube MVVM Products
//
//  Created by Yogesh Patel on 23/12/22.
//

import UIKit

class ProductListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var productTableView: UITableView!

    // MARK: - Variables
    private var viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }

    @IBAction func addProductButtonTapped(_ sender: UIBarButtonItem) {
        let product = AddProduct(title: "iPhone")
        viewModel.addProduct(parameters: product)
    }
}

extension ProductListViewController {

    func configuration() {
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
    }

    func initViewModel() {
        viewModel.fetchProducts()
    }

    // Data binding event observe karega - communication
    func observeEvent() {
        viewModel.eventHandler = { [weak self] event in
            guard let self else { return }

            switch event {
            case .loading:
                /// Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide kardo
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
                DispatchQueue.main.async {
                    // UI Main works well
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProductAdded(let newProduct):
                print(newProduct)
            }
        }
    }

}

extension ProductListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else {
            return UITableViewCell()
        }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }

}
