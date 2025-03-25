//
//  ViewController.swift
//  A2_iOS_elizabeth_101097106
//
//  Created by Elizabeth Thomas on 2025-03-23.
//

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var providerLabel: UILabel!
 
    @IBOutlet weak var searchBar: UISearchBar!
    
  
    var products: [Product] = []
    var currentIndex = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchProducts()
        if !products.isEmpty {
            displayProduct(at: 0)
        }
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
        if !products.isEmpty {
            displayProduct(at: currentIndex)
        }
    }

    @IBAction func prevButtonTapped(_ sender: Any) {
        if currentIndex > 0 {
            currentIndex -= 1
            displayProduct(at: currentIndex)
        } else {
            print("Reached the first product")
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if currentIndex < products.count - 1 {
            currentIndex += 1
            displayProduct(at: currentIndex)
        } else {
            print("Reached the last product")
        }
    }
    
    @IBAction func addProductButtonTapped(_ sender: UIBarButtonItem) {
       /* let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addProductVC = storyboard.instantiateViewController(withIdentifier: "AddProductViewController") as? AddProductViewController {
            self.navigationController?.pushViewController(addProductVC, animated: true)
        } */
        performSegue(withIdentifier: "AddProductSegue", sender: self)
    }
    
    
    func fetchProducts() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch products: \(error)")
        }
    }
    
    func displayProduct(at index: Int) {
        let product = products[index]
        nameLabel.text = product.name ?? "Unknown Product Name"
        descriptionLabel.text = product.productDescription ?? "No Description Available"
       // priceLabel.text = "Price: \(product.price)"
        priceLabel.text = String(format: "Price: $%.2f", product.price)
        providerLabel.text = "Provider: \(product.provider ?? "Unknown Provider")"
        
    }
    
    func searchProducts(with query: String) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@ OR productDescription CONTAINS[cd] %@", query, query)
        
        do {
            products = try context.fetch(fetchRequest)
            currentIndex = 0
            
            if !products.isEmpty {
                displayProduct(at: 0)
            } else {
                print("No matching products found")
                idLabel.text = ""
                nameLabel.text = ""
                descriptionLabel.text = ""
                priceLabel.text = ""
                providerLabel.text = ""
            }
        } catch {
            print("Error searching for products: \(error)")
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if !searchText.isEmpty {
            searchProducts(with: searchText)
        } else {
            fetchProducts()
            if !products.isEmpty {
                displayProduct(at: 0)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchProducts(with: query)
        searchBar.resignFirstResponder()
    }
    
    @IBAction func showAllProductsButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ProductListSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductListSegue",
           let destinationVC = segue.destination as? ProductListTableViewController {
            destinationVC.products = self.products
        }
    }
}

